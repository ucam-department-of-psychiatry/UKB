#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory


# change to your subject list
for sub in `cat allsubs.txt` ; do
#for sub in UKB1000028 ; do
	subject=${sub}
dataDir=/rds/project/rb643/rds-rb643-ukbiobank2/Data_Imaging
basedir=${dataDir}/${subject}
surfdir=${basedir}/surfaces/
statsdir=${basedir}/surfaces/${subject}/stats/
tmpDIR=/home/rb643/TempDir

export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

	if [ -e ${statsdir}/aseg.stats ]
	then
	# Run segstats
	mri_segstats --subject ${subject} --etiv-only > ${statsdir}/etiv.txt
	output="$(tail -n 1 ${statsdir}/etiv.txt)"
	echo ${subject} ${output}
	fi 
done
