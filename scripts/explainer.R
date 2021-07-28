tm_explainer <- function(workflow, dataset, target_Var, label = NULL) {
  return(
    explain_tidymodels(
      workflow,
      data = dataset,
      y = target_Var,
      
      #defaults 
      weights = NULL,
      predict_function = NULL,
      residual_function = NULL,
      
      label = label,
      verbose = TRUE,
      precalculate = TRUE,
      colorize = TRUE,
      model_info = NULL,
      type = NULL
    )
  )
}
