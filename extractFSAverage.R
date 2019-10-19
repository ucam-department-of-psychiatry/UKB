extractFSAverage <- function(hemi,...) {
  filelist <- read.table('allsubs.txt')
  source("https://raw.githubusercontent.com/hpardoe/struct.mri/master/load.mgh.R")
  
  out <- data.frame()
  
  for (i in filelist$V1) {
    eid <- i
    inputdir <-
      paste(
        '/rds-d4/project/rb643/rds-rb643-ukbiobank2/Data_Imaging',
        eid,
        'surfaces',
        eid,
        'surf',
        sep = .Platform$file.sep
      )
    inputfile <-
      paste(
        inputdir,
        paste(hemi,'.thickness.fwhm5.fsaverage.mgh',sep=""),
        sep = .Platform$file.sep
      )

    if (file.exists(inputfile)) {
      print(eid)
      tempOut <- t(load.mgh(inputfile)$x)
      rownames(tempOut) <- eid
      out <- rbind(out, tempOut)
    }

  }
  
  print('printing to file')
  write.table(out,
              file = paste('/rds-d4/project/rb643/rds-rb643-ukbiobank2/Scratch/',hemi,'_CT.csv',sep=""),
              quote=FALSE,
              row.names = TRUE,
              col.names = FALSE, 
              sep = ",")
  
}
