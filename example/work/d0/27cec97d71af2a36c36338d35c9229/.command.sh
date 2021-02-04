#!/bin/bash -ue
arboreto_with_multiprocessing.py         filtered.loom         test_TFs_tiny.txt         --method grnboost2         --num_workers 6         -o adj.tsv                           --cell_id_attribute CellID         --gene_attribute Gene
