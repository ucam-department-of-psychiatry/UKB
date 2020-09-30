#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory
indir=$1
logdir=$2
cd $indir
# get the subject files in the directory
filelist=$(find * -maxdepth 1 -type d -name 'UKB*')

# loop and submit fs jobs
for sub in ${filelist} ; do
#for sub in sub-10001 ; do

      if [ -d ${indir}/${sub}/surfaces/${sub} ] #for dataset with single sessions
      then
        echo 'running:' ${sub} 'session:' ${session} 'run: ' ${run}
        sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${logdir}/${sub}_LGI.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=12000 /rds/project/rb643-1/rds-rb643-ukbiobank2/Code/UKB_FS_LGI.sh ${sub}
      fi

done
