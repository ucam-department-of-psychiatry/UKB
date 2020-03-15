extractEuler_run <- function() {
  filelist <- read.table('newsubs.txt')
  source("extractEuler.R")
  
  outp <- data.frame()
  
  for (i in filelist$V1) {
    eid <- paste('UKB', i, sep = "")
    inputdir <-
      paste(
        '~/rds/rds-rb643-ukbiobank2/Data_Imaging',
        eid,
        'surfaces',
        eid,
        'surf',
        sep = .Platform$file.sep
      )
    if (file.exists(paste(inputdir,'/lh.orig.nofix',sep=""))) {
      print(eid)
	try({
      	tempOut <- extractEuler(inputdir, eid)
      	tempOut$oldID <- i
      	outp <- rbind(outp, tempOut)
	})
    }
  }

  write.table(outp,
              file = '~/rds/rds-rb643-ukbiobank2/Output/QC_R2_Euler.csv',
              quote=FALSE,
              row.names = FALSE,
              col.names = TRUE, 
              sep = ",")
  
}
