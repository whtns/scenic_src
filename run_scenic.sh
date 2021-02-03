#!/bin/bash

seu_path=$1
dataset=`basename $seu_path .rds`

proj_dir=`realpath $seu_path | xargs dirname | xargs dirname`

input_loom_path=`echo $proj_dir/scenic/$dataset.loom`
output_loom_path=`echo $proj_dir/scenic/$dataset-final.loom`

# echo $input_loom_path

script_path=`realpath $0 | xargs dirname`
# echo $script_path

Rscript "$script_path"/convert_seu_to_loom_scenic.R $seu_path

nextflow run aertslab/SCENICprotocol \
        -profile docker \
        --loom_input "$input_loom_path" \
        --loom_output "$output_loom_path" \
        --TFs ~/Homo_sapiens/scenic/hs_hgnc_curated_tfs.txt \
        --motifs ~/Homo_sapiens/scenic/motifs-v9-nr.hgnc.tbl \
        --db ~/Homo_sapiens/scenic/hg38_refseq-10kb_up_and_down_tss.mc9nr.feather \
        --thr_min_genes 1
