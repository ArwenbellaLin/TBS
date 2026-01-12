# FASTA base count (per chromosome + genome total)

This script counts the number of bases **A/T/C/G/N/Other** for each FASTA record (chromosome/contig) and also reports genome-wide totals.

## Input
- Genome FASTA file (one or more records)
- Chromosome name is taken as the first token after `>` (before spaces)

## Output
A tab-delimited text file with columns:

`Chrom, A, T, C, G, N, Other, ATCG_Total, All_Total`

- One row per chromosome/contig
- Last row: `GENOME_TOTAL` (sum across all records)

Default output filename:
- `<input_fasta_basename>.atcg_counts.txt` (written to current directory)

## Usage
```bash
python3 count_atcg.py /path/to/genome.fa