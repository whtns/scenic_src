#!/bin/bash -ue
pyscenic aucell         filtered.loom         reg.csv         -o pyscenic_output.loom         --cell_id_attribute CellID         --gene_attribute Gene         --num_workers 6
