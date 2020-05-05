#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory

dataDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Data_Imaging/
# change to your subject list
for subject in `cat allfiles.txt` ; do
basedir=${dataDir}/${subject}
	if [ -d ${basedir}/surfaces/${subject}/mri ]; then

	echo "Generating QC for: " ${subject}
	sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds/project/rb643-1/rds-rb643-ukbiobank2/logs/qc/${subject}_qclog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:15:00 --mem=12000 UKB_GenerateQC.sh ${subject}
	fi

done
