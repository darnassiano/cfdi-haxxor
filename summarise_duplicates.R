#!/usr/bin/env Rscript
# @darnassiano

summarise_duplicates <- function(x,column) {
  require(plyr)
  dfa = ddply(x,~column,summarise,numcolwise(sum))
  out_file = paste(x,"txt",sep=".")
  write.table(bios,out_file,quote=F,sep="\t",row.names=F,col.names=T)
  return(dfa)
}
