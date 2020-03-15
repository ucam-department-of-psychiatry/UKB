#!/bin/bash
#
# This script submits freesurfer jobs

subject=$1

dataDir=/home/rb643/rds/rds-rb643-ukbiobank2/Data_Imaging
basedir=${dataDir}/${subject}
surfdir=${basedir}/surfaces/${subject}/surf
tmpDIR=/home/rb643/TempDir

export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

	if [ -e ${surfdir}/lh.orig.nofix ]
	then
		echo "running left"
	mris_euler_number ${surfdir}/lh.orig.nofix 2> ${surfdir}/_lh_euler.txt
	fi

	if [ -e ${surfdir}/rh.orig.nofix ]
	then
		echo "running right"
	mris_euler_number ${surfdir}/rh.orig.nofix 2> ${surfdir}/_rh_euler.txt
	fi
