#!/bin/bash
#
# This script run freesurfer on HPC
#
#
# Set up variables

# subject directory within BIDS structure
subject=$1

dataDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Data_Imaging/
echo $subject

basedir=${dataDir}/${subject}
surfdir=${basedir}/surfaces/
tmpDIR=/home/rb643/TempDir/${subject}

# set up and make necessary subfolders
mkdir -p ${surfdir}
mkdir -p ${tmpDIR}

export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

# Run freesurufer
recon-all -subject ${subject} -i ${basedir}/anat/T1/T1_unbiased_brain.nii.gz -all -no-isrunning

rm -R ${tmpDIR}
