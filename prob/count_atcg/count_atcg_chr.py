#!/usr/bin/env python3
from __future__ import annotations
from typing import Iterator, Tuple, Dict
import argparse
import os
import sys

def fasta_chrom_iter(path: str) -> Iterator[Tuple[str, str]]:
    """
    Yield (chrom_name, sequence_string) for each FASTA record.
    chrom_name uses the first token after '>' (before any spaces).
    """
    chrom = None
    seq = []
    with open(path, "r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            if line.startswith(">"):
                if chrom is not None:
                    yield chrom, "".join(seq)
                chrom = line[1:].split()[0]
                seq = []
            else:
                seq.append(line)
        if chrom is not None:
            yield chrom, "".join(seq)

def count_bases(seq: str) -> Dict[str, int]:
    """Count A/T/C/G plus N and other IUPAC codes."""
    seq = seq.upper()
    counts = {"A": 0, "T": 0, "C": 0, "G": 0, "N": 0, "Other": 0}
    for b in seq:
        if b in ("A", "T", "C", "G", "N"):
            counts[b] += 1
        else:
            counts["Other"] += 1
    return counts

def finalize_counts(counts: Dict[str, int]) -> Dict[str, int]:
    counts = dict(counts)  # copy
    counts["ATCG_Total"] = counts["A"] + counts["T"] + counts["C"] + counts["G"]
    counts["All_Total"] = counts["ATCG_Total"] + counts["N"] + counts["Other"]
    return counts

def count_bases_per_chrom(fasta_path: str) -> Dict[str, Dict[str, int]]:
    per_chrom: Dict[str, Dict[str, int]] = {}
    for chrom, seq in fasta_chrom_iter(fasta_path):
        c = count_bases(seq)
        per_chrom[chrom] = finalize_counts(c)
    return per_chrom

def sum_genome(per_chr: Dict[str, Dict[str, int]]) -> Dict[str, int]:
    genome_total = {"A": 0, "T": 0, "C": 0, "G": 0, "N": 0, "Other": 0}
    for _, c in per_chr.items():
        for k in genome_total:
            genome_total[k] += c[k]
    return finalize_counts(genome_total)

def write_report(per_chr: Dict[str, Dict[str, int]], genome_total: Dict[str, int], out_path: str) -> None:
    header = ["Chrom", "A", "T", "C", "G", "N", "Other", "ATCG_Total", "All_Total"]
    with open(out_path, "w") as out:
        out.write("\t".join(header) + "\n")

        # 盡量用自然排序：chr1, chr2, ..., chr10; 其他放後面
        def chrom_key(name: str):
            n = name
            if n.startswith("chr"):
                n = n[3:]
            if n.isdigit():
                return (0, int(n))
            # X/Y/M/MT 等常見
            special = {"X": 23, "Y": 24, "M": 25, "MT": 25}
            if n in special:
                return (0, special[n])
            return (1, name)

        for chrom in sorted(per_chr.keys(), key=chrom_key):
            c = per_chr[chrom]
            row = [
                chrom,
                str(c["A"]), str(c["T"]), str(c["C"]), str(c["G"]),
                str(c["N"]), str(c["Other"]),
                str(c["ATCG_Total"]), str(c["All_Total"]),
            ]
            out.write("\t".join(row) + "\n")

        # genome total 最後一行
        gt = genome_total
        total_row = [
            "GENOME_TOTAL",
            str(gt["A"]), str(gt["T"]), str(gt["C"]), str(gt["G"]),
            str(gt["N"]), str(gt["Other"]),
            str(gt["ATCG_Total"]), str(gt["All_Total"]),
        ]
        out.write("\t".join(total_row) + "\n")

def main():
    ap = argparse.ArgumentParser(
        description="Count A/T/C/G/N/Other per chromosome and genome total from a FASTA."
    )
    ap.add_argument("fasta", help="Input genome FASTA (e.g., genome.fa)")
    ap.add_argument(
        "-o", "--out",
        default=None,
        help="Output txt path (default: <fasta_basename>.atcg_counts.txt in current dir)"
    )
    args = ap.parse_args()

    fasta_path = args.fasta
    if not os.path.exists(fasta_path):
        print(f"ERROR: FASTA not found: {fasta_path}", file=sys.stderr)
        sys.exit(1)

    if args.out is None:
        base = os.path.basename(fasta_path)
        out_path = f"{base}.atcg_counts.txt"
    else:
        out_path = args.out

    per_chr = count_bases_per_chrom(fasta_path)
    genome_total = sum_genome(per_chr)
    write_report(per_chr, genome_total, out_path)

    print(f"Done. Wrote: {out_path}")
    print(f"Genome ATCG_Total: {genome_total['ATCG_Total']}")
    print(f"Genome All_Total : {genome_total['All_Total']}")

if __name__ == "__main__":
    main()