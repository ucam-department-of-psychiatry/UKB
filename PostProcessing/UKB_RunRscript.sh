#!/bin/bash
#
# This script submits R jobs

dataDir=/rds-d4/project/rb643/rds-rb643-ukbiobank2/Code

for hemi in 'lh' 'rh' ; do

      echo '------------------------------------ working on' ${hemi} '-----------------------------------'
      sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/rds-d4/project/rb643/rds-rb643-ukbiobank2/logs/R_${hemi}.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=12:00:00 --mem=24000 RunR.sh ${hemi}

done
