#!/bin/bash
#
# This script copies output file to a specific folder
#
#

dataDir=/rds-d4/project/rb643/rds-rb643-ukbiobank2/Data_Imaging
transferFolder=/rds-d4/project/rb643/rds-rb643-ukbiobank2/Scratch/Stats
mkdir -p $transferFolder
mkdir -p $transferFolder/lh_ct_nosmooth/
mkdir -p $transferFolder/rh_ct_nosmooth/

for sub in `cat allsubs.txt` ; do

	if [ -e ${dataDir}/${sub}/surfaces/${sub}/surf/lh.thickness.fwhm5.fsaverage.mgh ]
	then
		echo ${sub}
		cp ${dataDir}/${sub}/surfaces/${sub}/surf/lh.thickness.fsaverage.mgh $transferFolder/lh_ct_nosmooth/${sub}_lh.thickness.fsaverage.mgh
		cp ${dataDir}/${sub}/surfaces/${sub}/surf/rh.thickness.fsaverage.mgh $transferFolder/rh_ct_nosmooth/${sub}_rh.thickness.fsaverage.mgh
	fi

done
