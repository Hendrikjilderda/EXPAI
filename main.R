#eventuele aanpassingen:
# combineren explainer.R en explainability_functions.R (hoort in theorie bij het zelfde onderwerp)
#
#

setwd("C:/Users/Hendrik/Documents/Programming/R/d99_xai_topservice")

#loading dependencies
source("scripts/load_packages.R")
source("scripts/custom_functions.R")

#making the model
source("scripts/load_dataset.R")
source("scripts/recipes.R")
source("scripts/model_RandomForest.R")

#explainability
source("scripts/explainer.R")
source("scripts/explainability_functions.R")
