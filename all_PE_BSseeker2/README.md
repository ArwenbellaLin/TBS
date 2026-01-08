# TBS PE pipeline (rmDupPE → TrimGalore → BSseeker2 → methylation calling)
This folder contains a bash pipeline for processing paired-end TBS (Targeted Bisulfite Sequencing) FASTQ files.
The workflow (per sample) is:

1. Remove PCR duplicates: `rmDupPE.pl`
2. Adapter/quality trimming: `TrimGalore` (paired-end)
3. Align trimmed reads to:
   - Human reference (hg19)
   - Spike-in reference (lambda)
   using `BSseeker2` (bowtie2 backend)
4. Call methylation on both alignments using `bs_seeker2-call_methylation.py`

**Important (TBS read order):** This pipeline swaps mates for tool input:
- mate1 (`-1`) uses the file named `*_R2_001.fastq.gz`
- mate2 (`-2`) uses the file named `*_R1_001.fastq.gz`

## Files
- `run.sh`  
  Main script to run the batch pipeline.

## Input
- Paired-end TBS FASTQ files
- Total: 271 libraries
- Naming convention:
  - `*_R1_001.fastq.gz`
  - `*_R2_001.fastq.gz`

## Output
For each sample, the pipeline generates the following types of files:

- Trimmed FASTQ files (optional)
  - `*_val_1.fq.gz`, `*_val_2.fq.gz`

- Alignment files
  - Paired-end BAM files aligned to hg19 or lambda (`*_PE.bam`)
  - Sorted/indexed BAM files (`*_sorted.bam`, `*.bai`)

- Methylation calling results
  - `*.ATCGmap.gz`
  - `*.CGmap.gz`
  - `*.wig.gz` (CG / CHG / CHH)

- Log files
  - `*.bs_seeker2_log`
  - `*.call_methylation_log`

## Notes
- Output files are named by sample ID.
- Not all intermediate files are required for downstream analysis.


