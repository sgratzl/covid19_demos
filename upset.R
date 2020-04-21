library(upsetjs)


df = read.csv('./data/covid_symptoms_table.csv', row.names=1)


upsetjs() %>% fromDataFrame(df) %>% interactiveChart()
