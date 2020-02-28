library(dplyr)
library(data.table)
library(matrixStats)

df <- read.table('Sublist.txt',header=FALSE)
df$NewID <- paste("UKB",df$V1,sep="")

# add the morphological variables
basepath <- "~/rds/rds-rb643-ukbiobank2/Data_Imaging/"
output1 <- data.frame()
output2 <- data.frame()
parcellationfolder <- "HCP.fsaverage.aparc_seq" 
parcellationfile <- "Connectivity_sc2345.txt"
for (i in unique(df$NewID)) {
  inputfile <- paste(basepath,i,"func","fMRI","parcellations",parcellationfolder,parcellationfile,sep=.Platform$file.sep)
  if(file.exists(inputfile)) {
    set.seed(1)
    mat <- as.matrix(read.table(inputfile, header=FALSE, sep=","))
    if(dim(mat)[2] == 376 && dim(mat)[1]== 376){
      print(i)
      tempMean <- as.data.frame(t(colMeans(mat)))
      tempSD <-  as.data.frame(t((colSds(mat))))
      tempMean$ID <- tempSD$ID <- i
      output1 <- rbind(output1,tempMean)
      output2 <- rbind(output2,tempSD)
    }
  }
}


write.csv(output1, file = '../Output/ConnectivityMean.csv', quote = FALSE)
write.csv(output2, file = '../Output/ConnectivitySdS.csv', quote = FALSE)

