#!/bin/bash
#
# This script projects CT to fsaverage as well as the mean denoised functional image`
# Warping files (*.lta) can also be re-used for later projecting functional images to fsaverage
#
# By:
# Richard A.I. Bethlehem
# University of Cambridge
# ©rb643 2019
#
# Set up variables and folder structure

module load freesurfer
module load fsl


subject=$1
dataDir=$2

echo 'working on ' $subject

basedir=${dataDir}/${subject}
surfdir=${basedir}/surfaces/
vol2surf=${basedir}/surfaces/vol2surf
tmpDIR=/home/rb643/TempDir/${subject}
funcDir=${basedir}/func/fMRI/rfMRI.ica/

# set up and make necessary subfolders
mkdir -p ${vol2surf}
mkdir -p ${tmpDIR}

export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

## First CT to resample_fsaverage
#recon-all -s "$subject" -qcache -measure thickness -no-isrunning

# Now the functional data
## Register to Freesurfer space
echo 'generating warps'
 fslmaths "$funcDir"/filtered_func_data_clean.nii.gz -Tmean "$funcDir"/"$subject"_denoised_mean.nii.gz
 bbregister --s "$subject" --mov "$funcDir"/"$subject"_denoised_mean.nii.gz --reg "$vol2surf"/"$subject"_fmri2fs_bbr.lta --init-fsl --bold

echo 'registering ' ${subject} ' to surface'
## Register mean file to surface
for x in lh rh; do
[[ $x == lh ]] && hemisphere=l || hemisphere=r
 mri_vol2surf \
      --mov "$funcDir"/"$subject"_denoised_mean.nii.gz \
      --reg "$vol2surf"/"$subject"_fmri2fs_bbr.lta \
      --projfrac-avg 0.2 0.8 0.1 \
      --trgsubject "$subject" \
      --interp trilinear \
      --hemi "$x" \
      --out "$vol2surf"/"$subject"_fmri2fs_mean_bbr_"$x".mgh
  # for s in 1 5 10 15; do
  #   mri_surf2surf \
  #   --srcsubject $subject \
  #   --sval "$vol2surf"/"$subject"_fmri2fs_mean_bbr_"$x".mgh \
  #   --trgsubject fsaverage --tval $vol2surf/"$subject"_fmri2fs_mean_fsaverage_s"$s"_"$x".mgh \
  #   --hemi $x \
  #   --nsmooth-out $s
  # done
done

# Register mean file to surface
for x in lh rh; do
[[ $x == lh ]] && hemisphere=l || hemisphere=r
 mri_vol2surf \
      --mov "$funcDir"/filtered_func_data_clean.nii.gz \
      --reg "$vol2surf"/"$subject"_fmri2fs_bbr.lta \
      --projfrac-avg 0.2 0.8 0.1 \
      --trgsubject "$subject" \
      --interp trilinear \
      --hemi "$x" \
      --out "$vol2surf"/"$subject"_fmri2fs_bbr_"$x".mgh
done

# clean up
echo 'cleaning temp folders'
rm ${tmpDIR}
