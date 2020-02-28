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
	   if [ ! -f ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/stats/rh.HCP.fsaverage.aparc.log ]; then
		run_subj=true
           else
		size_log=$(stat --printf="%s" ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/stats/rh.HCP.fsaverage.aparc.log)
           	if [ "$size_log" -gt "200" ]; then
			run_subj=false
		else	
			run_subj=true
		fi
	   fi
   run_subj=true
	   if [ "$run_subj" == true ]; then
		
		#Parallel
		mkdir -p ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/parcellation/
		cd ${SUBJECTS_DIR}/${sub}/surfaces/${sub}/parcellation/
		sbatch --account=BETHLEHEM-SL2-CPU --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=8000 --time=00:30:00 --output=/rds/project/rb643/rds-rb643-ukbiobank2/logs/${sub}.out /rds/project/rb643/rds-rb643-ukbiobank2/Code/parcellate.sh ${sub} $SUBJECTS_DIR 

		echo "${sub} submitted!"
#sbatch --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=8000 --time=00:30:00 /rds/project/rb643/rds-rb643-ukbiobank2/Code/parcellate.sh ${sub} $SUBJECTS_DIR
		

		#Serie		
		#sh /rds/project/rb643/rds-rb643-ukbiobank2/Code/parcellate.sh ${sub} $SUBJECTS_DIR
		#echo "${sub} ran sequentially!"
	   else
		echo "${sub} already parcellated!"
	   fi
	else
	   echo "${sub} Incomplete reconstruction"	
	fi
done

