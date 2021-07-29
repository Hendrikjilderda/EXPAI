randomforest_mod <- 
  rand_forest(mtry = tune(), trees = 500, min_n = tune()) %>%
  set_engine("randomForest") %>%
  set_mode("classification")

ml_workflow <-
  workflow() %>%
  add_recipe(data_rec) %>%
  add_model(randomforest_mod)


#######################################################################

set.seed(456)
folds <- vfold_cv(data_train)
# grid <- expand.grid(mtry = 1:9, min_n = 1:9)
grid <- expand.grid(mtry = 1:3, min_n = 1:3)

doParallel::registerDoParallel()

tune_res <- tune_grid(
  ml_workflow, resamples = folds, grid = grid)


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



best_params <- tune_res %>%
  tune::select_best(metric = "accuracy")


final_rf <- finalize_model(
  randomforest_mod,
  best_params
)

final_rf

final_rf %>%
  set_engine('randomForest') %>%
  fit(condition ~ ., data = juice(data_prep)  ) %>%
  vip(geom= 'point')

final_wf <- workflow() %>%
  add_recipe(data_rec) %>%
  add_model(final_rf)

final_res <- final_wf %>%
  last_fit(data_split)

final_res %>%
  collect_metrics()
##

test_test <- final_wf %>% fit(data=data_test)
test_train <- final_wf %>% fit(data=data_train)
fitted_model1 <- final_wf %>% fit(data=data_test) #is dit wel de juiste data voor fitting?
