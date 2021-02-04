#!/bin/bash -ue
filtering-basic.py         --loom_input expr_mat_tiny.loom         --loom_filtered filtered.loom         --thr_min_genes 1         --thr_min_cells 3         --thr_n_genes 20000         --thr_pct_mito 0.25
