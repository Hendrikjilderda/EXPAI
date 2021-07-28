data_rec <-
  recipe(condition ~ ., data = data_train) %>%
  step_mutate(
              sex = ifelse(sex == 1, 'male', 
                              'female'),
              
              chestPain = ifelse(chestPain == 1, 'Typical Angina', 
                                    ifelse(chestPain == 2, 'Atypical Angina', 
                                    ifelse(chestPain == 3,'non-Anginal Pain', 
                                    'Asymptomatic'))),
              
              bloodSugar = ifelse(bloodSugar == 1, '> 120 mg/dl', 
                                     '< 120 mg/dl'),
              
              ecg = ifelse(ecg == 0, 'Normal', 
                              ifelse(ecg == 1, 'ST-T wave abnormality', 
                              'Left ventricular hypertrophy')),
              
              indAngina = ifelse(indAngina == 1, 'Yes', 'No'),
              
              stSlope = ifelse(stSlope == 1, 'Upsloping', 
                                  ifelse(stSlope == 2, 'Flat', 
                                  'Downsloping')),
                                  
              scintigraphy = ifelse(scintigraphy == '3.0', 'Normal', 
                                       ifelse(scintigraphy == '6.0', 
                                       'Fixed Defect' , 
                                       'Reverseable Defect'))) %>%

  step_string2factor(all_nominal())
  
data_prep <- prep(data_rec)

data_juice <- juice(data_prep)
