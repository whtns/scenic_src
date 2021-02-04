#!/bin/bash -ue
pyscenic ctx         adj.tsv         genome-ranking.feather         --annotations_fname motifs.tbl         --expression_mtx_fname filtered.loom         --cell_id_attribute CellID         --gene_attribute Gene         --mode "dask_multiprocessing"         --output reg.csv         --num_workers 6
