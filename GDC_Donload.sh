#!bin/bash

# Program: Download TCGA controlled data from server. Token needed.
# Date: 2017/5/21
# Update: 2017/8/20
# Author: Kestin

# Conda Environment Setup
# 2016 Nov. Beta version of Centos6 seems to be developed. So,keep tracking.

# If you download the manifest directly from TCGA website and need to download 
# all files contained in the manifest, please use the commnad following directly.
#
# gdc-client download -m <Manifest> -t <Token> -d <output_dir>
#
# Latest update, add the log options and add the note above.
# PLEASE!!! Make sure the id_list as input is WITHOUT ANY headers (e.g. id)


OUT_dir="/outputdir"
token="/path/gdc-user-tokenfile.txt"
input=$1

while read line;do
	gdc-client download ${line} --log-file TCGAdownload.log -t ${token} -d ${OUT_dir}
done<${input}
exit 0
