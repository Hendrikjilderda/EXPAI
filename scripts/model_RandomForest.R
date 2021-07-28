randomforest_mod <- 
  rand_forest(mtry = tune(), trees = 1000, min_n = tune()) %>%
  set_engine("randomForest") %>%
  set_mode("classification")

ml_workflow <-
  workflow() %>%
  add_recipe(data_rec) %>%
  add_model(randomforest_mod)


#######################################################################

set.seed(456)
folds <- vfold_cv(data_train)
grid <- expand.grid(mtry = 1:6, min_n = 3:9)

all_cores <- parallel::detectCores(logical = TRUE) - 1
registerDoFuture()
cl <- makeCluster(all_cores)
plan(future::cluster, workers = cl)

tune_res <- tune_grid(
  ml_workflow, resamples = folds, grid = grid)

stopCluster(cl)


#uit vid
tune_res %>%
  collect_metrics() %>%
  filter(.metric == "accuracy") %>%
  select(mean, min_n, mtry) %>%
  pivot_longer(min_n:mtry,
               values_to = "value",
               names_to = "parameter"
  ) %>%
  ggplot(aes(value, mean, color = parameter)) +
  geom_point(show.legend = FALSE) +
  facet_wrap(~parameter, scales = "free_x") +
  labs(x = NULL, y = "Accuracy")
##


best_params <- tune_res %>%
  tune::select_best(metric = "accuracy")

best_params

optimized_rf <- finalize_model(
  randomforest_mod,
  best_params
)


#VIP library gebruikt
# uit vid
optimized_rf %>%
  set_engine('randomForest') %>%
  fit(condition ~ ., data = juice(data_prep)  ) %>%
  vip(geom= 'point')


# 
# final_rf <- ml_workflow %>% 
#   finalize_workflow(best_params) %>% 
#   fit(data= data_train)
# 
# 
# data_test <- testing(data_split)
# 
# final_rf %>%   
#   predict(new_data = data_test) 
#  # bind_cols(data_test, .) %>%
# #  select(condition, .pred_class) %>%
#  # accuracy(condition, .pred_class)




final_wf <- workflow() %>%
  add_recipe(data_rec) %>%
  add_model(final_rf)

final_res <- final_wf %>%
  last_fit(data_split)

final_res %>%
  collect_metrics()



#######################################################################

#uitzoeken hoe dit exact werkt!!!
# ctrl <- control_resamples(save_pred = T)
# folds <- vfold_cv(data_train)
# grid <- expand.grid(mtry = 1:6)
# 
# 
# #hoe werkt dit?
# all_cores <- parallel::detectCores(logical = TRUE) - 1
# registerDoFuture()
# cl <- parallel::makeCluster(all_cores)
# plan(future::cluster, workers = cl)
# 
# 
# #model trainen
# res <-
#   ml_workflow %>%
#   tune_grid(resamples = folds, control = ctrl, grid = grid)
# 
# #model tunen
# res %>% 
#   tune::collect_metrics()
# 
# 
# best_params <- res %>%
#     tune::select_best(metric = "accuracy")
# 
# best_params
# 
# 
# optimized_RandomForest <- 
#   ml_workflow %>%
#     finalize_workflow(best_params) %>%
#     fit(data = data_train)
# 
# data_test <- testing(data_split)
# 
# #hoe werkt dit?
# optimized_RandomForest %>%
#   predict(new_data = data_test) %>%
#   bind_cols(data_test, .) %>%
#   select(condition, .pred_class) %>%
#   accuracy(condition, .pred_class)


