#!/bin/bash
#
# This script runs freesurfer on the High Performance Cluster
# this is the subject specific script that can be called by SBATCH and only requires the subject ID as input
# assumes you have freesurfer set up (but otherwise you can add `module load freesurfer` to the top of this script
#
# By:
# Richard A.I. Bethlehem
# University of Cambridge
# ©rb643 2020
#
module load afni/17.0.00
module load freesurfer/6.0.0
module load matlab/r2019b
xdgDir=/home/rb643/TempDir/${sub}_LGI_xdg
mkdir -p ${xdgDir}

export XDG_RUNTIME_DIR=/home/rb643/TempDir/${sub}_${ses}
export MATLABPATH=/home/rb643/matlab/fmri_spt:/home/rb643/matlab/BWT_EXPnew:/home/rb643/matlab/BWT_EXPnew/BWT/:/home/rb643/matlab/fmri_spt/code_bin:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/dwt:/home/rb643/matlab/BWT_EXPnew/third_party/NIfTI:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/utils:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf

# subject directory within BIDS structure
subject=$1

echo $subject

# change to overearching bids directory
# change to your subject list
surfdir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Data_Imaging/${subject}/surfaces/
# also fix a tmpDIR to avoid using the system default tmpDIR that other users might access at the same time
tmpDIR=/home/rb643/TempDir/${subject}_LGI

# set up and make necessary subfolders
mkdir -p ${tmpDIR}

echo "exporting directories"
export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

# Run freesurufer
echo "running freesurfer"
recon-all -subject ${subject} -localGI

rm -R ${tmpDIR}
rm -R ${xdgDir}
