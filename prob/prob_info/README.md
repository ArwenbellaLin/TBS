# Probe CpG annotation and summary (hg19)

This folder contains intermediate files and analysis results for **annotating CpG sites in TBS probes** and summarizing probe-level CpG information based on the hg19 reference genome.

## Contents

- `analysis.ipynb`  
  Code used to annotate CpG sites within probe sequences and perform summary analysis.

- `20251204_Probes_merged_TE-92288275_hg19_*.tsv`  
  Merged probe annotation tables mapped to hg19 coordinates.

- `20251219_prob_merge_with_seq.csv`  
  Probe table merged with probe sequence information.

- `probe_CpG_CG_table.tsv`  
  Table listing CpG (CG) sites identified within each probe.

- `library_by_probeCpG_reads.tsv`  
  Summary table of read counts per library and per probe CpG.

## Input
- Probe annotation tables
- Probe sequence information
- hg19 reference genome–based coordinates

## Output
- CpG-annotated probe tables
- Probe-level CpG summary statistics
- Tables used for downstream methylation analysis

## Notes
- Files in this folder are intermediate results used for downstream analysis.
- All genomic coordinates are based on hg19.