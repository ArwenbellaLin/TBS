#!/bin/bash

#####################################################################
############### SE and PE mapping & with duplicates #################
#####################################################################
# #trim_galore
# /work4/home/hsieh/softwares/TrimGalore/trim_galore -q 20 -phred33 --fastqc --cores 10 --paired \
#     /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R2_001_rmdup.fastq.gz \
#     /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_rmdup.fastq.gz \
#     -o ./ &

# /work4/home/hsieh/softwares/TrimGalore/trim_galore -q 20 -phred33 --fastqc --cores 10 --paired \
#     /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R2_001_rmdup.fastq.gz \
#     /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_rmdup.fastq.gz \
#     -o ./ &

# /work4/home/hsieh/softwares/TrimGalore/trim_galore -q 20 -phred33 --fastqc --cores 10 --paired \
#     /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R2_001_rmdup.fastq.gz \
#     /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_rmdup.fastq.gz \
#     -o ./ &

# #trimmomatic
# java -jar /work4/home/guanjun/tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 10 -phred33 \
#    /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R2_001_rmdup.fastq.gz \
#    /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_rmdup.fastq.gz \
#    SGLTiFU-140_V3_R2_paired.fastq.gz SGLTiFU-140_V3_R2_unpaired.fastq.gz \
#    SGLTiFU-140_V3_R1_paired.fastq.gz SGLTiFU-140_V3_R1_unpaired.fastq.gz \
#    ILLUMINACLIP:/work4/home/guanjun/tools/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 &

# java -jar /work4/home/guanjun/tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 10 -phred33 \
#    /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R2_001_rmdup.fastq.gz \
#    /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_rmdup.fastq.gz \
#    SGLTiFU-143_V1_R2_paired.fastq.gz SGLTiFU-143_V1_R2_unpaired.fastq.gz \
#    SGLTiFU-143_V1_R1_paired.fastq.gz SGLTiFU-143_V1_R1_unpaired.fastq.gz \
#    ILLUMINACLIP:/work4/home/guanjun/tools/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 &

# java -jar /work4/home/guanjun/tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 10 -phred33 \
#    /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R2_001_rmdup.fastq.gz \
#    /work3/guanjun/temp/tbs_test/test_fullReads/rmDup/PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_rmdup.fastq.gz \
#    SGLTiFU-148_V1_R2_paired.fastq.gz SGLTiFU-148_V1_R2_unpaired.fastq.gz \
#    SGLTiFU-148_V1_R1_paired.fastq.gz SGLTiFU-148_V1_R1_unpaired.fastq.gz \
#    ILLUMINACLIP:/work4/home/guanjun/tools/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 &

# wait

# rm -f SGLTiFU-140_V3_R1_unpaired.fastq.gz SGLTiFU-140_V3_R2_unpaired.fastq.gz \
#     SGLTiFU-143_V1_R1_unpaired.fastq.gz SGLTiFU-143_V1_R2_unpaired.fastq.gz \
#     SGLTiFU-148_V1_R1_unpaired.fastq.gz SGLTiFU-148_V1_R2_unpaired.fastq.gz

# wait
# echo "Trim_galore and Trimmomatic done!"

# ##### SE #####

# # Reverse complement R1
# # 反補並壓縮成單一 gzip stream
# echo "[`date`] Reverse complement R1 ..."
# zcat PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_rmdup_val_2.fq.gz | seqtk seq -r - | gzip -c > PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_val_2_rev.fq.gz &
# zcat PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_rmdup_val_2.fq.gz | seqtk seq -r - | gzip -c > PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_val_2_rev.fq.gz &
# zcat PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_rmdup_val_2.fq.gz | seqtk seq -r - | gzip -c > PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_val_2_rev.fq.gz &

# wait

# # 確認檔案完整
# gzip -t PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_val_2_rev.fq.gz &
# gzip -t PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_val_2_rev.fq.gz &
# gzip -t PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_val_2_rev.fq.gz &

# wait
# echo "Reverse complement done!"
# Align
############ hg19 ############
echo "[`date`] Mapping R1 ..."

### SE R2 and R1_rev separately (local alignment)
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R2_001_rmdup_val_1.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-140_V3_hg19_R2.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R2_001_rmdup_val_1.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-143_V1_hg19_R2.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R2_001_rmdup_val_1.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-148_V1_hg19_R2.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &

/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-140_V3_hg19_R1_rev.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-143_V1_hg19_R1_rev.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-148_V1_hg19_R1_rev.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &

### PE R1 and R2 combined 

/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -1 PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R2_001_rmdup_val_1.fq.gz -2 PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-140_V3_hg19_PE.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -1 PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R2_001_rmdup_val_1.fq.gz -2 PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-143_V1_hg19_PE.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -1 PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R2_001_rmdup_val_1.fq.gz -2 PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/home/yuchun/human_HOTAIR/human_hg19/genome.fa --aligner=bowtie2 -o ./SGLTiFU-148_V1_hg19_PE.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/ &

############ Lambda ############
### SE R2 and R1_rev separately (local alignment)
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R2_001_rmdup_val_1.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-140_V3_lambda_R2.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R2_001_rmdup_val_1.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-143_V1_lambda_R2.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R2_001_rmdup_val_1.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-148_V1_lambda_R2.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &

/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-140_V3_lambda_R1_rev.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-143_V1_lambda_R1_rev.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -i PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-148_V1_lambda_R1_rev.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &

### PE R1 and R2 combined 

/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -1 PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R2_001_rmdup_val_1.fq.gz -2 PY-Plate-1-FP__SGLTiFU-140_V3_S72_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-140_V3_lambda_PE.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -1 PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R2_001_rmdup_val_1.fq.gz -2 PY-Plate-1-FP__SGLTiFU-143_V1_S41_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-143_V1_lambda_PE.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-align.py -1 PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R2_001_rmdup_val_1.fq.gz -2 PY-Plate-1-FP__SGLTiFU-148_V1_S43_L001_R1_001_val_2_rev.fq.gz \
    -g /work4/Genome/Enterobacteriophage_lambda/1993-04-28/Sequence/WholeGenomeFasta/genome.fa --aligner=bowtie2 -o ./SGLTiFU-148_V1_lambda_PE.bam -m 3 --bt2-p 10 --temp_dir=./ \
    -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/ &

wait
echo "Mapping completed!"

# 1. 確保都已經排序
echo "[`date`] Sorting BAM files ..."
samtools sort -@ 10 -o SGLTiFU-140_V3_hg19_R1_rev_sorted.bam SGLTiFU-140_V3_hg19_R1_rev.bam &
samtools sort -@ 10 -o SGLTiFU-140_V3_hg19_R2_sorted.bam SGLTiFU-140_V3_hg19_R2.bam &
samtools sort -@ 10 -o SGLTiFU-143_V1_hg19_R1_rev_sorted.bam SGLTiFU-143_V1_hg19_R1_rev.bam &
samtools sort -@ 10 -o SGLTiFU-143_V1_hg19_R2_sorted.bam SGLTiFU-143_V1_hg19_R2.bam &
samtools sort -@ 10 -o SGLTiFU-148_V1_hg19_R1_rev_sorted.bam SGLTiFU-148_V1_hg19_R1_rev.bam &
samtools sort -@ 10 -o SGLTiFU-148_V1_hg19_R2_sorted.bam SGLTiFU-148_V1_hg19_R2.bam &

samtools sort -@ 10 -o SGLTiFU-140_V3_lambda_R1_rev_sorted.bam SGLTiFU-140_V3_lambda_R1_rev.bam &
samtools sort -@ 10 -o SGLTiFU-140_V3_lambda_R2_sorted.bam SGLTiFU-140_V3_lambda_R2.bam &
samtools sort -@ 10 -o SGLTiFU-143_V1_lambda_R1_rev_sorted.bam SGLTiFU-143_V1_lambda_R1_rev.bam &
samtools sort -@ 10 -o SGLTiFU-143_V1_lambda_R2_sorted.bam SGLTiFU-143_V1_lambda_R2.bam &
samtools sort -@ 10 -o SGLTiFU-148_V1_lambda_R1_rev_sorted.bam SGLTiFU-148_V1_lambda_R1_rev.bam &
samtools sort -@ 10 -o SGLTiFU-148_V1_lambda_R2_sorted.bam SGLTiFU-148_V1_lambda_R2.bam &

wait
echo "Sorting completed!"

# 2. 合併
echo "[`date`] Merging sorted BAMs ..."
samtools merge -r -@ 10 SGLTiFU-140_V3_hg19_merged.bam SGLTiFU-140_V3_hg19_R1_rev_sorted.bam SGLTiFU-140_V3_hg19_R2_sorted.bam &
samtools merge -r -@ 10 SGLTiFU-143_V1_hg19_merged.bam SGLTiFU-143_V1_hg19_R1_rev_sorted.bam SGLTiFU-143_V1_hg19_R2_sorted.bam &
samtools merge -r -@ 10 SGLTiFU-148_V1_hg19_merged.bam SGLTiFU-148_V1_hg19_R1_rev_sorted.bam SGLTiFU-148_V1_hg19_R2_sorted.bam &

samtools merge -r -@ 10 SGLTiFU-140_V3_lambda_merged.bam SGLTiFU-140_V3_lambda_R1_rev_sorted.bam SGLTiFU-140_V3_lambda_R2_sorted.bam &
samtools merge -r -@ 10 SGLTiFU-143_V1_lambda_merged.bam SGLTiFU-143_V1_lambda_R1_rev_sorted.bam SGLTiFU-143_V1_lambda_R2_sorted.bam &
samtools merge -r -@ 10 SGLTiFU-148_V1_lambda_merged.bam SGLTiFU-148_V1_lambda_R1_rev_sorted.bam SGLTiFU-148_V1_lambda_R2_sorted.bam &

wait

# 3. 建立 index
samtools index SGLTiFU-140_V3_hg19_merged.bam &
samtools index SGLTiFU-143_V1_hg19_merged.bam &
samtools index SGLTiFU-148_V1_hg19_merged.bam &

samtools index SGLTiFU-140_V3_lambda_merged.bam &
samtools index SGLTiFU-143_V1_lambda_merged.bam &
samtools index SGLTiFU-148_V1_lambda_merged.bam &

wait

# Call methylation
echo "[`date`] Calling methylation ..."
# SE merged
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-140_V3_hg19_merged.bam \
      -o SGLTiFU-140_V3_hg19_merged.out \
      -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-143_V1_hg19_merged.bam \
      -o SGLTiFU-143_V1_hg19_merged.out \
      -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-148_V1_hg19_merged.bam \
      -o SGLTiFU-148_V1_hg19_merged.out \
      -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/genome.fa_bowtie2 &

/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-140_V3_lambda_merged.bam \
      -o SGLTiFU-140_V3_lambda_merged_global.out \
      -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-143_V1_lambda_merged.bam \
      -o SGLTiFU-143_V1_lambda_merged_global.out \
      -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-148_V1_lambda_merged.bam \
      -o SGLTiFU-148_V1_lambda_merged_global.out \
      -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/genome.fa_bowtie2 &

# PE
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-140_V3_hg19_PE.bam \
      -o SGLTiFU-140_V3_hg19_PE.out \
      -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-143_V1_hg19_PE.bam \
      -o SGLTiFU-143_V1_hg19_PE.out \
      -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-148_V1_hg19_PE.bam \
      -o SGLTiFU-148_V1_hg19_PE.out \
      -d /work4/home/guanjun/Genome/hg19/BS2_bt2_Index/genome.fa_bowtie2 &

/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-140_V3_lambda_PE.bam \
      -o SGLTiFU-140_V3_lambda_PE_global.out \
      -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-143_V1_lambda_PE.bam \
      -o SGLTiFU-143_V1_lambda_PE_global.out \
      -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/genome.fa_bowtie2 &
/work4/home/guanjun/tools/BSseeker2/bs_seeker2-call_methylation.py -i SGLTiFU-148_V1_lambda_PE.bam \
      -o SGLTiFU-148_V1_lambda_PE_global.out \
      -d /work4/home/guanjun/Genome/Lambda/BS2_bt2_Index_lambda/genome.fa_bowtie2 &

wait
echo "Methylation calling completed!"


