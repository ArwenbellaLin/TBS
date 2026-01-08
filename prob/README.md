# Count cytosine contexts in genome (hg19)

This script counts the number of **CG, CHG, and CHH contexts** in a reference genome FASTA file.
Counts are based on cytosine positions on the forward strand, with an option to include both strands.

## Input
- Reference genome FASTA file  
  - Default: `hg19`  
  - Path set in the script:
    ```
    /work4/Genome/Homo_sapiens/hg19/Sequence/WholeGenomeFasta/genome.fa
    ```

## What the script does
- Iterates through the genome FASTA sequence
- Counts cytosine contexts:
  - CG
  - CHG
  - CHH
- Optionally skips contexts containing `N`
- Optionally counts both forward strand only or both strands (forward + reverse complement)

## Output
The script returns a Python dictionary containing:
- `CG`: number of CG contexts
- `CHG`: number of CHG contexts
- `CHH`: number of CHH contexts
- `Total`: total number of cytosine contexts
- `Skipped_N_contexts`: number of contexts skipped due to `N`
- `mode`: `forward_only` or `both_strands`

## Usage
Run inside Python:

```python
res = count_genome_contexts(FASTA, both_strands=False, skip_n=True)
print(res)