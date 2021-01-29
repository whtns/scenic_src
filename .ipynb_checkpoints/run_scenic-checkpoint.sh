#!/bin/bash

dataset=$1

nextflow run aertslab/SCENICprotocol \
        -profile docker \
        --loom_input output/scenic/"$dataset".loom \
        --loom_output "$dataset"-final.loom \
        --TFs ~/Homo_sapiens/scenic/hs_hgnc_curated_tfs.txt \
        --motifs ~/Homo_sapiens/scenic/motifs-v9-nr.hgnc.tbl \
        --db ~/Homo_sapiens/scenic/hg38_refseq-10kb_up_and_down_tss.mc9nr.feather \
        --thr_min_genes 1
