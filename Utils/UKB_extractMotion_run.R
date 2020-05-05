source("extractMotionParams.R")

df <- read.table('newsubs.txt',header=FALSE)
df$NewID <- paste("UKB",df$V1,sep="")
basepath <- "~/rds/rds-rb643-ukbiobank2/Data_Imaging/"

output <- data.frame()
for (i in unique(df$NewID)) {
  inputfile <- file.path(basepath,i,'func','fMRI','rfMRI.ica','mc','prefiltered_func_data_mcf.par')
  if(file.exists(inputfile)){
    print(i)
    tempOut <- as.data.frame(extractMotionParams(inputfile))
    tempOut$eid <- i
    output <- rbind(output,tempOut)
  }
}

