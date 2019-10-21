#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory

dataDir=/rds-d4/project/rb643/rds-rb643-ukbiobank2/Data_Imaging

# change to your subject list
for subject in `cat allsubs.txt` ; do
#for subject in UKB1000028 ; do
  basedir=${dataDir}/${subject}
  surfdir=${basedir}/surfaces

  if [ -e ${surfdir}/${subject}/surf/lh.pial ]
    then

      echo '------------------------------------ working on' ${subject} '-----------------------------------'
      sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds-d4/project/rb643/rds-rb643-ukbiobank2/logs/vol2surf/${subject}_vol2surf.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:30:00 --mem=8000 UKB_vol2surf.sh ${subject} ${dataDir}
    else

      echo '--------------------------------- no fs files for ' ${subject} '--------------------------------'

  fi

done
