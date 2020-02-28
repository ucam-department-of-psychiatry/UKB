#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory


# change to your subject list
for subject in `cat newsubs.txt` ; do
subject='UKB'${subject}
dataDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Data_Imaging/
basedir=${dataDir}/${subject}
	if [ -e ${basedir}/anat/T1/T1_unbiased_brain.nii.gz ]; then
	if [ -e ${basedir}/anat/T2_FLAIR/T2_FLAIR_unbiased_brain.nii.gz ]; then
	echo "Running T1T2FS for: " ${subject}
	sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643-1/rds-rb643-ukbiobank2/logs/fs/${subject}_fslog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=20:00:00 --mem=12000 UKB_freesurfer.sh ${subject}
	elif [ ! -e ${basedir}/anat/T2_FLAIR/T2_FLAIR_unbiased_brain.nii.gz ]; then
	echo "Running T1OnlyFS for: " ${subject}
	sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643-1/rds-rb643-ukbiobank2/logs/fs/${subject}_fslog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=20:00:00 --mem=12000 UKB_freesurfer_T1Only.sh ${subject}
	fi
	fi

done
