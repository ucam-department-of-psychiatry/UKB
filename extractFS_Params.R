## Generic function to:
## Extract variables from a parcellated freesurfer files

## By:
## Richard A.I. Bethlehem
## University of Cambridge
## ©rb643 2019

## EXAMPLE USAGE:
## extractFS_Params("UKB1000028,"./Data_Imaging","lh.500_sym.aparc.log","rh.500_sym.aparc.log",4)
## 4 corresponds to cortical thickness

extractFS_Params <- function(ID,basepath,statsfile1,statsfile2,measureofinterest,...) {
  
  subject <- ID
  pathtostatsfile <- paste(basepath,subject,"surfaces",subject,"stats",sep=.Platform$file.sep)
  statsfileLH <- paste(pathtostatsfile,statsfile1,sep = .Platform$file.sep)
  statsfileRH <- paste(pathtostatsfile,statsfile2,sep = .Platform$file.sep)
  numberoflinestoskip <- 15
  surface <- 2
  volume <- 3
  label <- 10
  
  tempCT <- c(read.table(statsfileLH, skip=numberoflinestoskip)[,measureofinterest], 
              read.table(statsfileRH, skip=numberoflinestoskip)[,measureofinterest])
  tempSA <- c(read.table(statsfileLH, skip=numberoflinestoskip)[,surface], 
              read.table(statsfileRH, skip=numberoflinestoskip)[,surface])
  SA <- sum(tempSA)
  tempVol <- c(read.table(statsfileLH, skip=numberoflinestoskip)[,volume], 
               read.table(statsfileRH, skip=numberoflinestoskip)[,volume])
  GM_Vol <- sum(tempVol)
  
  tempCT <- as.data.frame(t(tempCT))
  tempLabel <- c(paste("lh_",as.character(read.table(statsfileLH, skip=numberoflinestoskip)[,label]),sep=""), 
                 paste("rh_",as.character(read.table(statsfileRH, skip=numberoflinestoskip)[,label]),sep=""))
  colnames(tempCT) <- tempLabel
  
  df <- tempCT
  df$NewID <- subject
  df$SA <- SA
  df$GM_Vol <- GM_Vol
  
  return(df)
   
}
