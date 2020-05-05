#!/bin/bash
sub=$1

# load all defaults
module load fsl/6.0.1
module load afni/17.0.00
module load freesurfer/6.0.0
soucre /home/rb643/Py37/bin/activate

# setup directories
topdir=/home/rb643/rds/rds-rb643-ukbiobank2/Data_Imaging/${sub}/surfaces/${sub}
qcdir=${topdir}/qc
mkdir -p ${qcdir}

# set processing directories
xdgDir=/home/rb643/TempDir/${sub}
mkdir -p ${xdgDir}
export XDG_RUNTIME_DIR=/home/rb643/TempDir/${sub}_${site}

# convert mgz
mri_convert --out_orientation RAS ${topdir}/mri/lh.ribbon.mgz ${qcdir}/lh.ribbon.nii.gz
mri_convert --out_orientation RAS ${topdir}/mri/rh.ribbon.mgz ${qcdir}/rh.ribbon.nii.gz
mri_convert --out_orientation RAS ${topdir}/mri/brain.mgz ${qcdir}/brain.nii.gz

cd ${qcdir}
3dcalc -a lh.ribbon.nii.gz -b rh.ribbon.nii.gz -expr 'step(step(a)+step(b))' -prefix ribbon.nii.gz

xvfb-run --server-args="-screen 0 1024x768x24" afni -noplugins -no_detach                               \
        -com "OPEN_WINDOW sagittalimage opacity=5 mont=3x1:25"          \
        -com "OPEN_WINDOW axialimage opacity=5 mont=3x1:20"             \
        -com "OPEN_WINDOW coronalimage opacity=5 mont=3x1:25"           \
        -com "SWITCH_OVERLAY ribbon.nii.gz"                          \
        -com "SEE_OVERLAY +"                                \
        -com "SET_XHAIRS OFF"                                \
        -com "SAVE_JPEG sagittalimage ${sub}_sag_ribbon.jpg blowup=2"     \
        -com "SAVE_JPEG coronalimage  ${sub}_cor_ribbon.jpg blowup=2"     \
        -com "SAVE_JPEG axialimage    ${sub}_axi_ribbon.jpg blowup=2"     \
        -com "QUITT"                                        \
      brain.nii.gz ribbon.nii.gz

rm -R *.nii.gz
rm -R ${xdgDir}
