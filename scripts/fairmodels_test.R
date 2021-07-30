# protected variable with subgroups
fobject <- fairness_check(explainer1,
                          protected = data_test$sex,
                          privileged = 1,
                          cutoff = 0.5,
                          colorize = TRUE)
fobject
plot(fobject)
