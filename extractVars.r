extractVars <- function(inputfile, varlist, outputfile, mri_only, ...){
  
  ##load the necescary libraries
  require(data.table)
  require(bit64)
  require(dplyr)
  ##read the raw data
  ukb <- fread(inputfile, header = T, sep = ',')
  
  if (mri_only == FALSE){
    ukb <- ukb
  } else if (mri_only == "T1"){
    ukb <- subset(ukb,`20252-2.0`== "20252_2_0")
  } else if (mri_only == "T2"){
    ukb <- subset(ukb,`20253-2.0`== "20253_2_0")
  } else if (mri_only == "rsfMRI") {
    ukb <- subset(ukb,`20227-2.0`== "20227_2_0")
  } else {
    warning("No MR selection option recognized, using T1 only")
    ukb <- subset(ukb,`20252-2.0`== "20252_2_0")
  }
  
  ## load the list of variables
  varlist <- fread(varlist, header = F)
  colnames(varlist) <- "variables"
  
  ## match variable list to dataset
  idx <- match(varlist$variables, names(ukb))

  ## extraxt data and add subject id
  NewDf <- select(ukb,"eid",idx)
  
  ## return the new dataframe
  return(NewDf)
}