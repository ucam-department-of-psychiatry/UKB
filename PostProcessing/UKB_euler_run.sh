#!/bin/bash
#

for subject in `cat newsubs.txt` ; do
#  for subject in 1000118 ; do
subject='UKB'${subject}

	echo "Running Euler Index for: " ${subject}
	sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=/home/rb643/rds/rds-rb643-ukbiobank2/logs/eulerlog/${subject}_euler.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:10:00 --mem=4000 UKB_euler.sh ${subject}

done
