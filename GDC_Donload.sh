#!bin/bash
# Program: Download TCGA controlled data from server. Token needed.
# Date: 2017/5/21
# Update: Need input the sonload id sheet, in order to download in parallel

# Conda Environment Setup

OUT_dir="/outputdir"
token="/path/gdc-user-tokenfile.txt"
input=$1

while read line;do
	gdc-client download ${line} -t ${token} -d ${OUT_dir}
done<${input}
exit 0
