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
sub_dirs=${sub}/surfaces/
SUBJECTS_DIR=$2/${sub_dirs}/

fsaverage_subid=fsaverage
chmod -R 775 $SUBJECTS_DIR
cd $SUBJECTS_DIR
fsaverage_path=/home/rr480/software/freesurfer/subjects/$fsaverage_subid/
#if [ -d ${SUBJECTS_DIR}/$fsaverage_subid/ ] || [ -f ${SUBJECTS_DIR}/$fsaverage_subid/ ]; then
	rm ${SUBJECTS_DIR}/$fsaverage_subid
#fi

ln -s $fsaverage_path ${SUBJECTS_DIR}/$fsaverage_subid

if [ -f ${SUBJECTS_DIR}/${sub}/label/rh.aparc.annot ] && [ ! "${sub}" = 'fsaverage' ]; then
	echo ${SUBJECTS_DIR}/${sub}
	#for parcellation in PALS_B12_Lobes ; do 
	for parcellation in economo Schaefer_200 Schaefer_400 500_sym.aparc 500.aparc sjh PALS_B12_Lobes aparc HCP.fsaverage.aparc ; do 
		for hemi in lh rh ; do
			if [ ! -f ${SUBJECTS_DIR}/${sub}/label/${hemi}.${parcellation}.annot ]; then
			mri_surf2surf --srcsubject ${fsaverage_subid} \
				            --sval-annot ${SUBJECTS_DIR}/${fsaverage_subid}/label/${hemi}.${parcellation} \
				            --trgsubject ${sub} \
				            --trgsurfval ${SUBJECTS_DIR}/${sub}/label/${hemi}.${parcellation} \
				            --hemi ${hemi}

			fi
		done

		if [ ! -f ${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}.nii.gz ]; then
			mkdir ${SUBJECTS_DIR}/${sub}/parcellation/
			mri_aparc2aseg --s ${sub} \
                        	--o ${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}.nii.gz \
                        	--annot ${parcellation} \
                        	--rip-unknown \
                        	--hypo-as-wm
		fi

		if [ ! -f ${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}_seq.nii.gz ]; then
			#echo "renumDesikan_sub('${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}.nii.gz',1);exit" > temp.m
			#matlab -nodisplay -r "temp"
			
			matlab -nodisplay -r "renumDesikan_sub('${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}.nii.gz',1);exit"
		fi

		for hemi in lh rh ; do
			if [ ! -s ${SUBJECTS_DIR}/${sub}/stats/${hemi}.${parcellation}.log ]; then
		        mris_anatomical_stats -a ${SUBJECTS_DIR}/${sub}/label/${hemi}.${parcellation}.annot -b ${sub} ${hemi} > ${SUBJECTS_DIR}/${sub}/stats/${hemi}.${parcellation}.log
			fi

			if [ ! -s ${SUBJECTS_DIR}/${sub}/stats/${hemi}_${parcellation}.w-g.pct.stats ]; then
			mri_segstats --in ${SUBJECTS_DIR}/${sub}/surf/${hemi}.w-g.pct.mgh --annot ${sub} ${hemi} ${parcellation} --sum ${SUBJECTS_DIR}/${sub}/stats/${hemi}_${parcellation}.w-g.pct.stats --snr 
			fi
		done

	done
fi
rm ${SUBJECTS_DIR}/$fsaverage_subid

