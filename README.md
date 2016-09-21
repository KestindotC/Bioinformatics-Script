# LAB Common Pipeline
Few of common bioinformatic analysis pipelines in our lab listed below, beginners in learning sequencing analysis should familiar with the principle and arguments meanings of each tools.

1. RNA seq 
2. DNA seq (Denovo only)
3. Rep seq



## RNA sequencing analysis pipeline
We use tophat2, HISAT2 and STAR. Tophat2 have been announced entered a low maintenance. So, be careful to follow the update info in Tophat.(https://ccb.jhu.edu/software/tophat/index.shtml)

Tophat2 --> featureCounts --> DEseq2(Normalization only) --> output as .txt or .csv
STAR --> featureCounts --> DEseq2
HISAT2 --> HTseq --> log2 normalization
