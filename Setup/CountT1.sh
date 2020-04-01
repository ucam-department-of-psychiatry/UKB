#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory


# change to your subject list
for subject in `cat allfiles.txt` ; do
dataDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Data_Imaging/
basedir=${dataDir}/${subject}
	if [ -e ${basedir}/anat/T1/T1_unbiased_brain.nii.gz ]; then
	if [ -e ${basedir}/anat/T2_FLAIR/T2_FLAIR_unbiased_brain.nii.gz ]; then
	echo "T1T1," ${subject}
	elif [ ! -e ${basedir}/anat/T2_FLAIR/T2_FLAIR_unbiased_brain.nii.gz ]; then
	echo "T1," ${subject}
	fi
	fi

done
