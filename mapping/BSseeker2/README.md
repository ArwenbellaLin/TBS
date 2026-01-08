# BSseeker2 pipeline (test script; 3 libraries)

This folder contains a **test bash script** for running BSseeker2 alignment and methylation calling on **3 TBS libraries**.
It maps reads to **hg19** and **lambda** references, then generates BAM files and methylation outputs.

## Input
This test script was run using the 3 TBS libraries (after rmDup + trimming):
- SGLTiFU-140_V3
- SGLTiFU-143_V1
- SGLTiFU-148_V1 

- Expected files in this test are example trimmed reads:
  - `*_R2_001_rmdup_val_1.fq.gz`
  - `*_R1_001_rmdup_val_2_rev.fq.gz` (reverse-complemented)

**Note (TBS read order):**
- R2 is used as mate1 / forward input
- R1 is reverse-complemented first, then used as mate2

## What the script does
1. (optional; commented) trimming with TrimGalore / Trimmomatic
2. Reverse-complement R1 (for SE mapping and for PE mate2)
3. BSseeker2 alignment to:
   - hg19
   - lambda
   for:
   - SE mapping (R2 and R1_rev separately)
   - PE mapping (R2 + R1_rev)
4. Sort BAMs and merge SE BAMs (R2 + R1_rev → `*_merged.bam`)
5. Index merged BAMs (`*.bai`)
6. Call methylation on:
   - merged SE BAM (`*_merged.bam`)
   - PE BAM (`*_PE.bam`)

## Output (per sample)
Main output types:

- Alignment BAMs
  - `*_hg19_R2.bam`, `*_hg19_R1_rev.bam`, `*_hg19_PE.bam`
  - `*_lambda_R2.bam`, `*_lambda_R1_rev.bam`, `*_lambda_PE.bam`
  - merged SE BAM: `*_hg19_merged.bam`, `*_lambda_merged.bam`
  - sorted/indexed: `*_sorted.bam`, `*.bai`

- Methylation calling results
  - `*.ATCGmap.gz`
  - `*.CGmap.gz`
  - `*.wig.gz` (CG/CHG/CHH tracks)

- Logs
  - `*.bs_seeker2_log`
  - `*.call_methylation_log`

## Usage
Edit paths in the script if needed (BSseeker2, references, input FASTQs), then run:

```bash
bash run.sh