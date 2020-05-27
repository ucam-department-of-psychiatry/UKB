#!/bin/bash
#
# This script copies output file to a specific folder
#
#

dataDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Data_Imaging
transferFolder=/rds/project/rb643-1/rds-rb643-ukbiobank2/Output/QC/
mkdir -p $transferFolder

for sub in `cat allfiles.txt` ; do

	if [ -d ${dataDir}/${sub}/surfaces/${sub}/qc/ ]
	then
		echo 'copying qc for: '${sub}
		cp ${dataDir}/${sub}/surfaces/${sub}/qc/*.jpg $transferFolder/
		#cp ${dataDir}/${sub}/func/fMRI/parcellations/HCP.fsaverage.aparc_seq/ts_sc2345.txt $transferFolder2/${sub}_ts_sc2345.txt
		#cp ${dataDir}/${sub}/surfaces/${sub}/surf/rh.thickness.fsaverage.mgh $transferFolder/rh_ct_nosmooth/${sub}_rh.thickness.fsaverage.mgh
	fi

done
