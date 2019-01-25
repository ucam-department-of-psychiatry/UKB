#!/bin/bash
#
# This script runs freesurfer on the High Performance Cluster
# this is the subject specific script that can be called by SBATCH and only requires the subject ID as input
# assumes you have freesurfer set up (but otherwise you can add `module load freesurfer` to the top of this script
#
# By:
# Richard A.I. Bethlehem
# University of Cambridge
# ©rb643 2019
#
# Set up variables and folder

# subject directory within BIDS structure
subject=$1

echo $subject
# change to overearching bids directory
dataDir=rds-rb643-ukbiobank2/Data_Imaging
basedir=${dataDir}/${subject}
surfdir=${basedir}/surfaces/
# also fix a tmpDIR to avoid using the system default tmpDIR that other users might access at the same time
tmpDIR=/home/rb643/TempDir

# set up and make necessary subfolders
mkdir -p ${surfdir}
mkdir -p ${tmpDIR}

export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

# Run freesurufer
recon-all -subject ${subject} -i ${basedir}/anat/T1/T1_unbiased_brain.nii.gz -T2 /${basedir}/anat/T2_FLAIR/T2_FLAIR_unbiased_brain.nii.gz -T2pial -all -no-isrunning

