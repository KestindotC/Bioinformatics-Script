# Program: For RNA-seq data, initial normalization after getting the sample first.
# Date: 2017/5/21
# Update: Code refactoring

# Check if DEseq2 have been installed in your R envirnonment
source("https://bioconductor.org/biocLite.R")
biocLite("DESeq2")
library("DESeq2")


### For HTseq output (DEseq2DataSetFromHTSeqCount function could be applied directly after obtaining the HTseq results)
# directory<-"C:/Users/Kestin/Documents/Immunosequencing/GSE79338/RNAcount"
# sampleFiles<-grep("count.",list.files(directory),value=TRUE)
# sampleNames<-sub("_chr14_*.*","\\1",sampleFiles)
# sampleCondition<-c("Non-glioma","Non-glioma","Non-glioma",
#                    "Low-glioma","Low-glioma","Low-glioma",
#                    "Glioblastoma","Glioblastoma","Glioblastoma","Glioblastoma",
#                    "Glioblastoma","Glioblastoma","Glioblastoma","Glioblastoma")
# sampleTable<-data.frame(sampleName = sampleNames,
#                         fileNmae = sampleFiles,
#                         condition = sampleCondition)
# dds<-DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
#                                 directory = directory,
#                                 design = ~ condition)
#  
# dds<-dds[rowSums(counts(dds))>1,]
# dds<-estimateSizeFactors(dds)
# test<-head(counts(dds, normalized = TRUE))
# write.csv(counts(dds, normalized=TRUE),file = 'GSE79338_chr14RNA.csv')


### For FeatureCount output
WD <- '/tempwork173/kestin/TCGA_COAD/RNA-seq'
data <- 'Colorectal_RNAexp_fullchecked0313.txt'
setwd(WD)

countData <- read.table(data, header = T, row.names = 1)
countdata <- as.matrix(countdata)

colData <- cbind(colnames(countData),'COAD')
colData <- as.data.frame(colData)
colnames(colData) <- c('sp','condition')
# sample and condition
rownames(colData) <- colData$sp
colData$sp <- NULL


dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design = ~ 1) # No condition

dds <- dds[rowSums(counts(dds))>1,]
dds <- estimateSizeFactors(dds)
normalized.count <- counts(dds,normalized = T)
dds_trans = normTransform(dds, f = log2, pc = 1)
log2.normalized.count <- assay(dds_trans)

write.table(log2.normalized.count,file = 'Colorectal_RNAseq_Nomalized_Count.txt',quote = F, sep = '\t')
write.table(log2.normalized.count,file = 'Colorectal_RNAseq_Nomalized_Count_log2.txt',quote = F, sep = '\t')

# Standard transformation using z score (Remember to write to a new files)
log2.normalized.z.count <- t(scale(t(log2.normalized.count)))
