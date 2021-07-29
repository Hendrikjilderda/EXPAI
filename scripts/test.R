#testing
blyat <- data_test[-14]

explainer1 <- tm_explainer(test_test, dataset = data_test[-14], target_var = as.factor(data_test$condition), label = 'randomForest' )
explainer2 <- tm_explainer(test_train , dataset = data_train[-14], target_var = as.factor(data_train$condition), label = 'randomForest2' )
explainer3 <- tm_explainer(fitted_model1 , dataset = dataset[-14], target_var = as.factor(dataset$condition), label = 'randomForest3' )


temp <-single_custom_model_parts(explainer = explainer1)
plot(temp)

temp2 <-single_custom_model_parts(explainer = explainer2)
plot(temp2)

temp3 <-single_custom_model_parts(explainer = explainer3)
plot(temp3)

triple <- multi_custom_model_parts(explainer1, explainer2, explainer3)


library(ggplot2)
plot(temp, temp2, temp3) + ggtitle("Mean variable-importance over 50 permutations", "")

