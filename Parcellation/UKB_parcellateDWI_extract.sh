#!/bin/bash
#####
# Transform the parcellation from standard space to native space
# Rafael Romero Garcia
# rr480@cam.ac.uk
# University of Cambridge 2017
#####

#First paratemer $sub is the name of the folder of the subject that want to be processed
#Second parameter is the folder where the freesurfer folders are located

sub=$1
#sub_dirs=${sub}/surfaces/
SUBJECTS_DIR=$2
#/${sub_dirs}/

cd $SUBJECTS_DIR
module load afni/17.0.00
if [ -f ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/label/rh.aparc.annot ] && [ ! "${sub}" = 'fsaverage' ]; then
	echo ${SUBJECTS_DIR}/${sub}

	for parcellation in economo Schaefer_200 Schaefer_400 500_sym.aparc 500.aparc sjh PALS_B12_Lobes aparc HCP.fsaverage.aparc ; do 
		path_out=${SUBJECTS_DIR}/${sub}/DWI/parcellations/${parcellation}/
		path_par=${SUBJECTS_DIR}/${sub}/DWI/parcellations/${parcellation}_dwiSpace.nii.gz
		path_fa=${SUBJECTS_DIR}/${sub}/DWI/dMRI/dMRI/dti_FA.nii.gz
		path_md=${SUBJECTS_DIR}/${sub}/DWI/dMRI/dMRI/dti_MD.nii.gz
		mkdir -p $path_out
	
		if [ -f $path_par ]; then
			if [ -f $path_fa ]; then
				if [ ! -f $path_out/FA.txt ]; then
					3dROIstats -nobriklab -nomeanout -nzmean -quiet -mask $path_par $path_fa > $path_out/FA.txt
				fi
			  else
			  	echo "FA not found: $path_fa"
			fi
		
			if [ -f $path_md ]; then
				if [ ! -f $path_out/MD.txt ]; then
					3dROIstats -nobriklab -nomeanout -nzmean -quiet -mask $path_par $path_md > $path_out/MD.txt
				fi
			  else
			  	echo "FA not found: $path_md"
			fi

		else
			echo "Parcellation not found: $path_par"
		fi
	done
fi

