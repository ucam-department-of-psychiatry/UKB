#!/bin/bash

# change to overearching bids directory
baseDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/

# read your subject list
#for sub in `cat allsubs.txt` ; do
for sub in UKB1000028; do
  subj='UKB'${sub}
  taskfile=${baseDir}/temp/${sub}_20249_2_0.zip
  if [ -e  ${taskfile} ]; then
  echo 'unzipping subject ' ${subj}

  #outDir=${baseDir}/Data/${sub}/anat
     outDir=${baseDir}/Data_Imaging/${sub}/func/
     unzip ${taskfile} -d ${outDir}
  fi
done
