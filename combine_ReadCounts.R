#!/usr/bin/Rscript
# Program: combine HTseq output or featureCounts (processed) result
# Date: 2016/09/22
# Copyright 2016 Yi-Hsuan Chang
# Only support featureCounts(Bioinformatics, 30(7):923-30), with all files in a directory.

library("optparse")

option_list = list(
  make_option(c("-w", "--workdir"), type="character", default=NULL, 
              help="directory of files. e.g.<'/home/master/test_data'>", metavar="<FilesDirectory>"),
  make_option(c("-r", "--regex"), type="character", default="featureCounts*.txt", 
              help="regex of file names [default= %default]", metavar="<regex>")
)
opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser);

if (is.null(opt$workdir)){
  print_help(opt_parser)
  stop("At least one argument must be supplied (Path or Regex)", call.=FALSE)
}

crawler <- function(path,filesregex){
  ExpressionProfile <- data.frame()
  setwd(path)
  samples <- dir(path = './',pattern = glob2rx(filesregex),ignore.case = T)
  for (flag in c(1:length(samples))){
    FileName <- samples[flag]
    count <- read.table(FileName, header = T, comment.char = '#')
    
    if (flag==1) {
      ExpressionProfile <- count[,c(1,7)]
      next
    }

    cname <- colnames(count)[7]
    message(samples[flag]," processing...")
    
    count <- count[cname]
    ExpressionProfile <- cbind(ExpressionProfile,count)
    rm(count)
  }
  write.csv(ExpressionProfile,'Expression.csv')
  
}

crawler(path = opt$workdir,filesregex = opt$regex)

