library(shiny)
library(crosstalk)
library(lineupjs)


df = read.csv('./data/PatientInfo.csv', row.names=1)
df$birth_year = as.numeric(df$birth_year)

ui = fluidPage(
  titlePanel("Covid 19 Patient Infos"),
  p(
    "Data from: ",
    a(href="https://www.kaggle.com/kimjihoo/coronavirusdataset#PatientInfo.csv
", "Kaggle")),
  lineupOutput("lineup1")
)


server = function(input, output, session) {
  output$lineup1 <- renderLineup({
    lineup(as.data.frame(df[c('sex', 'birth_year', 'age', 'country', 'state')]), width = "100%")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
