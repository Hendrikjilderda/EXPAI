#eventuele aanpassingen:
# combineren explainer.R en explainability_functions.R (hoort in theorie bij het zelfde onderwerp)
#
# prediction profile for what if 
#https://rdrr.io/cran/DALEX/man/predict_profile.html

setwd("C:/Users/Hendrik/Documents/Programming/R/EXPAI")

#loading dependencies
source("scripts/load_packages.R")
#source("scripts/custom_functions.R")

#making the model
source("scripts/load_dataset.R")
source("scripts/recipes.R")
source("scripts/explainer.R")
source("scripts/model_RandomForest.R")

#running the modelStudio dashboard
ms


source("scripts/fairmodels_test.R")

fairness_check(explainer1)

#explainability

source("scripts/explainability_functions.R")

source("scripts/test.R")
