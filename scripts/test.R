#testing
explainer1 <- tm_explainer(test_test, test_dataset = data_test, target_Var = as.factor(data_test$condition), label = 'randomForest' )
explainer2 <- tm_explainer(test_train , test_dataset = data_train, target_Var = data_train$condition, label = 'randomForest2' )
explainer3 <- tm_explainer(fitted_model1 , test_dataset = dataset, target_Var = dataset$condition, label = 'randomForest3' )


single_custom_model_parts(explainer = explainer1)

multi_custom_model_parts(explainer1, explainer2, explainer3)
