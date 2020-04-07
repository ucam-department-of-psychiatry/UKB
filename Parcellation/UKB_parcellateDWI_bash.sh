#####
# Iterates across all subjects to transform the parcellation from standard space to native space
# Rafael Romero Garcia
# rr480@cam.ac.uk
# University of Cambridge 2017
#####

#SUBJECTS_DIR=/rds/project/rb643/rds-rb643-ukbiobank2/Rafa_scratch/
SUBJECTS_DIR=/rds/project/rb643/rds-rb643-ukbiobank2/Data_Imaging/
#SUBJECTS_DIR=/rds/project/rb643/rds-rb643-abcd/Data_Imaging/


cd $SUBJECTS_DIR
for sub in * ; do
	if [ -f ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/label/rh.aparc.annot ]; then
	   if [ ! -f ${SUBJECTS_DIR}/${sub}/DWI/dMRI/parcellations/QUITA ]; then
	
		#Parallel
		mkdir -p ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/parcellation/
		cd ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/parcellation/

		#Parcellate DWI individual subjects
		sbatch --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=8000 --time=00:01:00 /rds/project/rb643/rds-rb643-ukbiobank2/Code/UKB_parcellateDWI_extract.sh ${sub} $SUBJECTS_DIR

		echo "${sub} submitted!"
		#Serie
		#sh /rds/project/rb643/rds-rb643-ukbiobank2/Code/parcellateDWI.sh ${sub} $SUBJECTS_DIR
		#sh /rds/project/rb643/rds-rb643-ukbiobank2/Code/parcellateDWI_extract.sh ${sub} $SUBJECTS_DIR
		#echo "${sub} ran sequentially!"
		#exit
	   else
		echo "${sub} already parcellated!"
	   fi
	else
	   echo "${sub} Incomplete reconstruction"
	fi
done
