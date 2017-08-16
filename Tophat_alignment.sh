#!/bin/bash
# Program: FASTQ transform to bam and index bam finish
# Tophat with NCBI GRCh37 to get the T cell receptor constant region (exon)
# /work171/kestin/iGenome_Kestin contain all reference

################ INFO YOU NEED TO OFFER ###############
WORKD=/work171/kestin/gse79338/

#######################################################
cd $WORKD
ls -1 *.fastq > sample.txt
# Read the data filenames lines
while read line
do
name=`ls $line | cut -c 1-3`
mkdir tophat_${name}

tophat2 -p 10 -o ./tophat_${name} \
-G /work171/kestin/iGenome_Kestin/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf \
-g 1 \
/work171/kestin/iGenome_Kestin/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome \
./${line}
echo "alignment FINISH !!!"

cd tophat_${name}/
samtools sort acce*.bam ${name}_sorted
samtools index ${name}_sorted.bam
cd ../
echo "FINISH ${name} !!!"

done <sample.txt
unset name
exit 0
