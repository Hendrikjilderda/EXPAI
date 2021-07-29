#testing

explainer1 <- tm_explainer(test_test, dataset = data_test[-14], target_var = as.factor(data_test$condition), label = 'randomForest' )
explainer2 <- tm_explainer(test_train , dataset = data_train[-14], target_var = as.factor(data_train$condition), label = 'randomForest2' )
explainer3 <- tm_explainer(fitted_model1 , dataset = dataset[-14], target_var = as.factor(dataset$condition), label = 'randomForest3' )

exp_warning <- tm_explainer(test_test)

temp <-single_custom_model_parts(explainer = explainer1)
plot(temp)

temp2 <-single_custom_model_parts(explainer = explainer2)
plot(temp2)

temp3 <-single_custom_model_parts(explainer = explainer3)
plot(temp3)

triple <- multi_custom_model_parts(explainer1, explainer2, explainer3)

double <- multi_custom_model_parts(explainer1 = explainer2, explainer3 = explainer3)


library(ggplot2)
plot(temp, temp2, temp3) + ggtitle("Mean variable-importance over 50 permutations", "")


ez_run <-function(){
  explainer1 <- tm_explainer(test_test, dataset = data_test[-14], target_var = as.factor(data_test$condition), label = 'testing' )
  temp <-single_custom_model_parts(explainer = explainer1)
  plot(temp)
  
}

ez_run()




# geeft rare waarden. NaN en 0
model_perf <- model_performance(explainer2)
model_perf
plot(model_perf, geom = "boxplot")









library("DALEXtra")
library("tidymodels")
library("recipes")
data <- titanic_imputed
data$survived <- as.factor(data$survived)
rec <- recipe(survived ~ ., data = data) %>%
  step_normalize(fare)
model <- decision_tree(tree_depth = 25) %>%
  set_engine("rpart") %>%
  set_mode("classification")

wflow <- workflow() %>%
  add_recipe(rec) %>%
  add_model(model)


model_fitted <- wflow %>%
  fit(data = data)

explain_tidymodels(model_fitted, data = titanic_imputed, y = titanic_imputed$survived)


compare_pdp(explainer1 = explainer1, explainer2 = explainer2, wanted_variable = 'cholesterol')

