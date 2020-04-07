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

if [ -f ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/label/rh.aparc.annot ] && [ ! "${sub}" = 'fsaverage' ]; then
	echo ${SUBJECTS_DIR}/${sub}

	for parcellation in economo Schaefer_200 Schaefer_400 500_sym.aparc 500.aparc sjh PALS_B12_Lobes aparc HCP.fsaverage.aparc ; do 
		path_out=${SUBJECTS_DIR}/${sub}/DWI/parcellations/
		mkdir -p ${path_out}
		path_dwi=${SUBJECTS_DIR}/${sub}/DWI/dMRI/dMRI.bedpostX/nodif_brain.nii.gz
		path_t1=${SUBJECTS_DIR}/${sub}/surfaces/${sub}/mri/brainmask.nii.gz
		
		if [ ! -f $path_t1 ]; then
			mri_convert ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/mri/brainmask.mgz $path_t1
		fi

		if [ ! -f ${path_out}/t12dwi.txt ]; then
			echo 'Corregistering'
			flirt 	-in ${path_dwi} -ref ${path_t1} -out $path_out/dwi_t1space.nii.gz -omat ${path_out}/dwi2t1.txt
			convert_xfm -omat ${path_out}/t12dwi.txt -inverse ${path_out}/dwi2t1.txt
		fi

		if [ ! -f $path_out/${parcellation}_dwiSpace.nii.gz ]; then
			flirt -in ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/parcellation/${parcellation}_seq.nii.gz -ref $path_dwi -out $path_out/${parcellation}_dwiSpace.nii.gz -interp nearestneighbour -applyxfm -init ${path_out}/t12dwi.txt
		fi

	done
fi

