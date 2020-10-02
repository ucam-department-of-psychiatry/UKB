# Quality control structural imaging
In addition to the standard measures provided by UK BioBank we conducted some minimal quality control across subjects to look for potentially obvious biases. Since our most basic analyses generally involve cortical thickness and the estimation of CT from our freesurfer pipeline will likely reflect general reconstruction success this is the main measure of output we currently used.


![QC example 1](/Figures/QC_CT_categorical.png)
***Figure 1:*** *Basic associations of mean whole-brain cortical thickness with potential categorical covariates of influence. There is a clear subset of individuals with a reduced mean CT profile. Visualisation suggests this difference to be mainly driven by whether or not the freesurfer reconstruction was able to use a T2-FLAIR in addition to the standard T1. It appears the combined T1 T2-FLAIR recon-all run estimates on average higher cortical thickness.*


We also explored some dimensional possible association with global CT and found there to be no systematic confound comparable to the type of pipeline used for reconstruction.
![QC example 2](/Figures/QC_CT_categorical_dimesnional.png)
***Figure 2:*** *The age at scan showed a small and significant negative association with cortical thickness, which is what would be expected. BMI showed no significant relation. There did not seem to be a systematic association with the Euler index and mean CT or Euler index and type of pipeline. Although the combined pipeline showed a slightly wider distribution of Euler indices they did not differ significantly*

# Covariates covariance structure
To explore covariance structure of the most common covariates we looked at the robust bend correlation coefficient and each covariates relative contribution to global cortical thickness when included on one simple linear model.
![QC example](/Figures/QC_Covar_correlation_explainedVariance.png)
***Figure 3:*** *Covariates covariance structure*
