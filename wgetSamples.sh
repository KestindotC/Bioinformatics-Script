#!/bin/bash
#Program:
#Download all samples from a bioproject


#Configuration
WD=/home/bioinfo/Data/SRA_repSeq/rawdata
#Please offter the SRR id table,one sample per line
files=sampleid.txt

cd $WD
# Read the data filenames lines (Usisng wrong method)
# filenames="./sampleid.txt"
# exec<$filenames

# New loop to readlines
while read line; do
	len=${#line}
	substr1=`echo ${line} | cut -c 1-6`
	substr2=`echo ${line} | cut -c 1-$len`
	wget "ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/$substr1/$substr2/$substr2.sra"
	# If you need background execute please add -b parameters
done<${files}


exit 0
