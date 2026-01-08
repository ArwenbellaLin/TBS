# BSBolt (BSB) pipeline test (hg19, PE; 3 libraries)

This folder contains a **test script** for running BSBolt alignment and methylation calling on **3 TBS libraries** (paired-end) mapped to **hg19**.

## Input (test libraries)
- SGLTiFU-140_V3
- SGLTiFU-143_V1
- SGLTiFU-148_V1

Input FASTQ examples (paired-end, trimmed):
- `*_R2_001_val_1.fq.gz` (F1)
- `*_R1_001_val_2.fq.gz` (F2)

## What the script does
1. (optional; commented) `bsbolt Align` to hg19 → PE BAM
2. Methylation calling pre-processing (samtools)
   - `samtools fixmate`
   - `samtools sort`
   - `samtools markdup` (remove duplicates)
   - `samtools index`
3. `bsbolt CallMethylation` → methylation text output

## Output (per sample)
- Alignment / intermediate BAMs
  - `*_hg19_bsbolt_PE.bam*`
  - `*.fixmates.bam`
  - `*.sorted.bam`
  - `*.dup.bam` and `*.dup.bam.bai`

- Methylation calling
  - `*_hg19_bsbolt_PE.methylation.txt`

## Usage
Edit paths (FASTQ inputs, BSBolt DB) if needed, then run:
```bash
bash run.sh