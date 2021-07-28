#possible problem with predict funtion and residual function

tm_explainer <- function(fitted_model, test_dataset, target_Var, label = NULL) {
  return(
    explain_tidymodels(
      model = fitted_model,
      data = test_dataset,
      y = as.numeric(target_Var),
      label = label,
      
      #defaults 
      weights = NULL,
      predict_function = NULL,
      residual_function = NULL,
      

      verbose = TRUE,
      precalculate = TRUE,
      colorize = TRUE,
      model_info = NULL,
      type = NULL
    )
  )
}
