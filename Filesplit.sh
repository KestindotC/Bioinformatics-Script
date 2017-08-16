#!/bin/bash
#Program:
#After Downloading all samples in a bioproject, we need to split files of .SRA

cd /home/bioinfo/Data/SRA_repSeq/rawdata
# get all samples filename
ls *.sra > filenames.txt
filename="./filenames.txt"
exec<$filename
while read line; do
	#statements
	whichfile=`echo ${line}`
	name=`echo ${line} | cut -c 1-10`

	fastq-dump -O /home/bioinfo/Data/SRA_repSeq/$name --split-files $whichfile 
	#Quality default is 33 Phred! 
done

exit 0