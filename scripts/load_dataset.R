setwd('./data')
dataset <- read.csv('heart.csv',  stringsAsFactor = TRUE)
setwd('..')

colnames(dataset) <- c('age',
                       'sex',
                       'chestPain',
                       'bloodPressure',
                       'cholesterol',
                       'bloodSugar',
                       'ecg',
                       'maxHeartRate',
                       'indAngina',
                       'stDepression',
                       'stSlope',
                       'numVessels',
                       'scintigraphy',
                       'condition')

dataset$condition <-  ifelse(dataset$condition == 1, 'CAD+', 'CAD-')
set.seed(9876)
data_split <- initial_split(dataset, prop = 0.70)
data_train <- training(data_split)
data_test <- testing(data_split)
