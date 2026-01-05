#!/bin/bash
# : "${VAL1:=}"
# : "${VAL2:=}"
# : "${VAL3:=}"
set -euo pipefail

# ============================================================
# Batch TBS pipeline: rmDupPE -> TrimGalore(PE) -> BSseeker2(lambda) -> call methylation(lambda)
# Concurrency: keep 10 libraries running; finish one, start next
# NOTE (TBS): filename R1/R2 need to be swapped for tool input
#   mate1 = RAW_R2 (filename R2)
#   mate2 = RAW_R1 (filename R1)
# ============================================================

# === Input and output ===
INPUT_DIR="/work3/guanjun/file/Human_diabetes_TBS/downloads/fastq"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR"

# === Concurrency control ===
MAX_JOBS=10

# === Parameters ===
TRIM_CORES=1    # trim_galore --cores # 10
BT2_P=15          # BSseeker2 --bt2-p
MISMATCH=3        # BSseeker2 -m

# === Tools ===
RMDUP="/work1/home/yenmr/bin/rmDupPE.pl"
TRIMGALORE="/work4/home/hsieh/softwares/TrimGalore/trim_galore"
BSSEEKER="/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py"
BSCALL="/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py"

# === hg19 reference ===
GENOME_HG19_FA="/work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa"
GENOME_HG19_IDX="/work4/home/guanjun/Genome/hg19/BS2_bt2_Index/"
GENOME_HG19_BS2="${GENOME_HG19_IDX%/}/genome.fa_bowtie2"

# === Lambda reference ===
GENOME_LAMBDA_FA="/work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa"
GENOME_LAMBDA_IDX="/work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/"
GENOME_LAMBDA_BS2="${GENOME_LAMBDA_IDX%/}/genome.fa_bowtie2"

# === Output folders ===
mkdir -p "$OUTPUT_DIR"/{rmdup,trimmed,mapped_hg19,mapped_lambda,methylation_hg19,methylation_lambda,logs}
mkdir -p "$OUTPUT_DIR"/{rmdup,trimmed,mapped_lambda,methylation_lambda,logs}

SUMMARY="$OUTPUT_DIR/logs/summary_TBS_lambda_pipeline.txt"
echo "=== TBS lambda pipeline started at $(date) ===" > "$SUMMARY"
echo "INPUT_DIR=$INPUT_DIR" >> "$SUMMARY"
echo "OUTPUT_DIR=$OUTPUT_DIR" >> "$SUMMARY"
echo "MAX_JOBS=$MAX_JOBS" >> "$SUMMARY"
echo "TRIM_CORES=$TRIM_CORES, BT2_P=$BT2_P, MISMATCH=$MISMATCH" >> "$SUMMARY"
echo "" >> "$SUMMARY"

# === helper: limit concurrent background jobs to MAX_JOBS ===
limit_jobs () {
  while [ "$(jobs -pr | wc -l)" -ge "$MAX_JOBS" ]; do
    sleep 5
  done
}

shopt -s nullglob
R1_FILES=("$INPUT_DIR"/*_R1_001.fastq.gz)

if [ ${#R1_FILES[@]} -eq 0 ]; then
  echo "❌ No *_R1_001.fastq.gz found in $INPUT_DIR" | tee -a "$SUMMARY"
  exit 1
fi

for RAW_R1 in "${R1_FILES[@]}"; do
(
  RAW_R2="${RAW_R1/_R1_001.fastq.gz/_R2_001.fastq.gz}"
  if [ ! -f "$RAW_R2" ]; then
    echo "⚠️  Skipping $(basename "$RAW_R1") (no matching R2)" | tee -a "$SUMMARY"
    exit 0
  fi

  SAMPLE="$(basename "$RAW_R1" | sed 's/_R1_001.fastq.gz//')"
  LOG="$OUTPUT_DIR/logs/${SAMPLE}.log"

  echo "===================================================" >> "$LOG"
  echo "SAMPLE=$SAMPLE" >> "$LOG"
  echo "Start: $(date)" >> "$LOG"
  echo "RAW_R1=$RAW_R1" >> "$LOG"
  echo "RAW_R2=$RAW_R2" >> "$LOG"

  echo "▶ [$SAMPLE] start $(date)" | tee -a "$SUMMARY"

  # ------------------------------------------------------------
  # TBS swap rule:
  #   mate1 input = filename R2
  #   mate2 input = filename R1
  # ------------------------------------------------------------
  IN_MATE1="$RAW_R2"
  IN_MATE2="$RAW_R1"

  # === Step 1: rmDupPE (keep same order as your original commands) ===
  RMDUP_MATE1="$OUTPUT_DIR/rmdup/${SAMPLE}_R2_001_rmdup.fastq.gz"
  RMDUP_MATE2="$OUTPUT_DIR/rmdup/${SAMPLE}_R1_001_rmdup.fastq.gz"

  # echo "▶ [$SAMPLE] rmDupPE ..." | tee -a "$SUMMARY"
  # "$RMDUP" \
  #   "$IN_MATE1" "$IN_MATE2" \
  #   "$RMDUP_MATE1" "$RMDUP_MATE2" >> "$LOG" 2>&1

  # # === Step 2: TrimGalore (paired; order matters, keep mate1 then mate2) ===
  # echo "▶ [$SAMPLE] TrimGalore ..." | tee -a "$SUMMARY"
  # "$TRIMGALORE" -q 20 -phred33 --fastqc --cores "$TRIM_CORES" --paired \
  #   "$RMDUP_MATE1" "$RMDUP_MATE2" \
  #   -o "$OUTPUT_DIR/trimmed" >> "$LOG" 2>&1

  # TrimGalore outputs are based on input filenames:
  #   <mate1>_val_1.fq.gz and <mate2>_val_2.fq.gz
  BASE1="$(basename "$RMDUP_MATE1")"
  BASE2="$(basename "$RMDUP_MATE2")"
  VAL1="$OUTPUT_DIR/trimmed/${BASE1%.fastq.gz}_val_1.fq.gz"
  VAL2="$OUTPUT_DIR/trimmed/${BASE2%.fastq.gz}_val_2.fq.gz"

  if [ ! -f "$VAL1" ] || [ ! -f "$VAL2" ]; then
    echo "❌ [$SAMPLE] TrimGalore outputs not found:" | tee -a "$SUMMARY"
    echo "   expected: $VAL1" | tee -a "$SUMMARY"
    echo "   expected: $VAL2" | tee -a "$SUMMARY"
    exit 1
  fi

  # === Step 3: BSseeker2 align (hg19 + lambda, PE; run in parallel) ===
  BAM_HG19="$OUTPUT_DIR/mapped_hg19/${SAMPLE}_hg19_PE.bam"
  BAM_LAMBDA="$OUTPUT_DIR/mapped_lambda/${SAMPLE}_lambda_PE.bam"

  echo "▶ [$SAMPLE] BSseeker2 align hg19 + lambda ..." | tee -a "$SUMMARY"

  "$BSSEEKER" -1 "$VAL1" -2 "$VAL2" \
    -g "$GENOME_HG19_FA" --aligner=bowtie2 \
    -o "$BAM_HG19" -m "$MISMATCH" --bt2-p "$BT2_P" --temp_dir="$OUTPUT_DIR" \
    -d "$GENOME_HG19_IDX" >> "$LOG" 2>&1 &

  "$BSSEEKER" -1 "$VAL1" -2 "$VAL2" \
    -g "$GENOME_LAMBDA_FA" --aligner=bowtie2 \
    -o "$BAM_LAMBDA" -m "$MISMATCH" --bt2-p "$BT2_P" --temp_dir="$OUTPUT_DIR" \
    -d "$GENOME_LAMBDA_IDX" >> "$LOG" 2>&1 &

  wait  # 等兩個 alignment 都做完

  # === Step 4: Call methylation (hg19 + lambda; run in parallel) ===
  OUT_HG19="$OUTPUT_DIR/methylation_hg19/${SAMPLE}_hg19_PE_global.out"
  OUT_LAMBDA="$OUTPUT_DIR/methylation_lambda/${SAMPLE}_lambda_PE_global.out"

  echo "▶ [$SAMPLE] Call methylation hg19 + lambda ..." | tee -a "$SUMMARY"

  "$BSCALL" -i "$BAM_HG19" \
    -o "$OUT_HG19" \
    -d "$GENOME_HG19_BS2" >> "$LOG" 2>&1 &

  "$BSCALL" -i "$BAM_LAMBDA" \
    -o "$OUT_LAMBDA" \
    -d "$GENOME_LAMBDA_BS2" >> "$LOG" 2>&1 &

  wait  # 等兩個 methylation calling 都做完

) &

  # keep at most MAX_JOBS libraries running
  limit_jobs
done

wait
echo "=== All samples finished at $(date) ===" | tee -a "$SUMMARY"
echo "✅ Summary saved to $SUMMARY"