extractDWI <- function(filelist,outfile,parcellation,...) {
  filelist <- read.table(filelist)

  outp <- data.frame()

  for (i in filelist$V1) {
    eid <- paste('UKB', i, sep = "")
    inputdir <-
      paste(
        '/home/rds/rds/rds-rb643-ukbiobank2/Data_Imaging',
        eid,
        'DWI',
        'parcellations',
        parcellation,
        sep = .Platform$file.sep
      )
    if (file.exists(paste(inputdir,'MD.txt',sep=""))) {
      print(eid)
	try({
      	tempOut <- read.table()
      	tempOut$ID <- eid
      	outp <- cbind(outp, tempOut)
	})
    }
  }

  write.table(outp,
              file = outfile,
              quote=FALSE,
              row.names = FALSE,
              col.names = TRUE,
              sep = ",")

}
