#!/usr/bin/env python3

import pandas as pd
import numpy as np
from sys import argv
import re

#Print header line
# print("Basename\tMeasure\tValue")

def process_file_genes(file):
    gff = pd.read_csv(file, sep="\t", comment="#", header=None)
    basename = re.search(pattern=r'([^/]+)\.gff', string=file).group(1)
    
    gff['ID'] = gff[8].str.extract(r'ID=([^;]+)')

    gff['Parent'] = gff[8].str.extract(r'Parent=([^;]+)')

    gff['length'] = gff[4] - gff[3] + 1

    # print(gff.head())
    
    total_genes = (gff[2] == 'gene').sum()
    mean_mrna_len = gff[gff[2].str.contains('transcript|mRNA')].length.mean()
    mean_cds_len = gff[gff[2] == "CDS"].groupby("Parent").length.sum().mean()
    med_cds_len = gff[gff[2] == "CDS"].groupby("Parent").length.sum().median()
    mean_exons_len = gff[gff[2] == "exon"].groupby("Parent").length.sum().mean()
    med_exons_len = gff[gff[2] == "exon"].groupby("Parent").length.sum().median()

    mean_introns_ct = gff[gff[2] == "exon"].groupby("Parent")[0].count().mean() - 1
    # Add assertion that every gene has > 0 exons
    try:
        assert all(gff[gff[2] == "exon"].groupby("Parent")[0].count() > 0)
    except AssertionError:
        print("Warning: File Has Transcripts with Missing Exons! Please check the input file.")

    intron_ctgt_one = (
        gff[gff[2] == "exon"].groupby("Parent")[0].count() > 1
    ).sum() / total_genes


    # print(intron_ctgt_one)

    # Pretty print the results
    print(f"{basename}\tGene Count\t{total_genes}")
    print(f"{basename}\tMean mRNA Length\t{mean_mrna_len:.2f}")
    print(f"{basename}\tMean Exons Length\t{mean_exons_len:.2f}")
    print(f"{basename}\tMedian Exons Length\t{med_exons_len:.0f}")
    print(f"{basename}\tMean CDS Length\t{mean_cds_len:.2f}")
    print(f"{basename}\tMedian CDS Length\t{med_cds_len:.0f}")
    print(f"{basename}\tAvg Introns Per mRNA\t{mean_introns_ct:.2f}")
    print(f"{basename}\tPercent Genes with 0 Introns\t{1.0 - intron_ctgt_one:.4f}")



#iterate through each file in input
for file in argv[1:]:
    process_file_genes(file)
