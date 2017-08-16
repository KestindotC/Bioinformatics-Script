#!/bin/bash
# Program: MiXCR all pipeline wrapped in.
WorkD=/home/bioinfo/Data/SRA_repSeq/Untreated/alpha_chain
REFfile=/home/bioinfo/Data/SRA_repSeq/
#Alignment for Treated-TRA
cd $WorkD
ls -1 | cut -c 7-10 > namefile
NAME="./namefile"
exec<$NAME

while read line; do
cd SRR154${line}/
mixcr align --loci TRA -r "Untreated_HIV+_alpha_${line}_align.log" -a -p rna-seq -OvParameters.geneFeatureToAlign=VTranscript "Untreated_HIV+_alpha_${line}.fastq" "Untreated_HIV+_alpha_${line}.vdjca"

#Clone for Treated-TRA
mixcr assemble -r "Untreated_HIV+_alpha_${line}_cln.log" --index indexFile_${line} Untreated_HIV+_alpha_${line}.vdjca Untreated_HIV+_alpha_${line}.clns

#Export alignment and assemble report
mixcr exportClones -pf $REFfile/standardout_TRAclo.txt --filter-stops Untreated_HIV+_alpha_${line}.clns clones_export_${line}.txt

mixcr exportAlignments -targets 1 -pf $REFfile/standardout_TRAali.txt -cloneIdWithMappingType indexFile_${line} -descrR1 Untreated_HIV+_alpha_${line}.vdjca alignments_export_${line}.txt
cd ../
done
unset NAME
exit 0

