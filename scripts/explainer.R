#possible problem with predict funtion and residual function

tm_explainer <- function(fitted_model, dataset = NULL, target_var = NULL, label = NULL) {
  if(is.null(dataset)){
    warning('dataset not needed but recommended')
  }
  
  if(is.null(target_var)){
    warning('target variable not needed but recommended')
  }
  
  if(is.null(label)){
    warning('label not needed but highly recommended for plots')
  }
  
  return(
    explain_tidymodels(
      model = fitted_model,
      data = dataset,
      y = as.numeric(target_var),
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
