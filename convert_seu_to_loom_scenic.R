#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
    stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
    # default input file
    # args[2] = "../output/seurat/unfiltered_seu.rds"
}

library(seuratTools)
library(sceasy)
library(reticulate)
library(fs)

loompy <- reticulate::import('loompy')
scanpy <- reticulate::import('scanpy')

# dataset <- "allfeatures_only_pt_seu"
# dataset <- "allfeatures_only_pt_w_ctrl_seu"
seu_path <- args[1]
dataset <- fs::path(seu_path)

adata_path <- gsub("seurat", "scenic", path_ext_set(seu_path, "h5ad"))
loom_path <- gsub("seurat", "scenic", path_ext_set(seu_path, "loom"))
# print(dataset)

seu <- readRDS(seu_path)

# kept_metadata <- c("nCount_RNA", "nFeature_RNA", "sample_id")
#
# kept_metadata <- c("nCount_RNA", "nFeature_RNA", "sample_id", "batch",
#   "integrated_snn_res.0.2", "integrated_snn_res.0.4", "integrated_snn_res.0.6", "integrated_snn_res.0.8",
#   "integrated_snn_res.1.2", "integrated_snn_res.1.4", "integrated_snn_res.1.6",
#   "integrated_snn_res.1.8", "integrated_snn_res.2", "integrated_snn_res.1",
#   "S.Score", "G2M.Score", "Phase")
#
# seu@meta.data <- seu@meta.data[,kept_metadata]

for(j in 1:ncol(seu@meta.data)){
    if(is.factor(seu@meta.data[,j]) == T){
        seu@meta.data[,j] = as.character(seu@meta.data[,j]) # Force the variable type to be character
        seu@meta.data[,j][is.na(seu@meta.data[,j])] <- "NA"
    }
    if(is.character(seu@meta.data[,j]) == T){
        seu@meta.data[,j][is.na(seu@meta.data[,j])] <- "NA"
    }
}

message("converting")

seu <- Seurat::RenameAssays(seu, gene = "RNA")

sceasy::convertFormat(seu, from="seurat", to="anndata",
                      outFile=adata_path)

adata <- scanpy$read(adata_path)
adata$write_loom(loom_path)
