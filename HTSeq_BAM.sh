#!/bin/bash
# Program:
#	Get all sorted bam to HTseq file
# LastUpdate: 2016/07/24
# Input format : absolute path such as
# e.g. /tempwork171/kestinGSE79338/glio/G07_laign.bam
# HTseq should be updated! Can accept the bam file as input!

################## INFO YOU NEED TO MODIFY ################
WD=/work171/kestin/gse79338
howmanyfiles=14
annotation_path=/work171/kestin/iGenome_Kestin/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf
###########################################################
cd $WD
mkdir htseqResult
find -name '*sorted.bam' > temp
#cat temp | sed -e 's/^./\/NFSShare\/kestin\/GSE79338\/non/' > input.txt
cat temp > input.txt

file='./input.txt'

for ((i=1;i< ${howmanyfiles};i++));do
	TEXT=$(cat input.txt | awk '{FS="/"} NF>1 {print $NF}' | sed -n "${i}p" | sed 's/_sorted.bam$//g')
	line=$(cat input.txt | sed -n "${i}p")
# echo $line
# echo $TEXT
htseq-count -f bam -s no -q -t exon \
-i gene_name "${line}" $annotation_path > ${WD}/htseqResult/${TEXT}_HTcount.txt
 
done
rm temp input.txt
exit 0

