library(shiny)
library(upsetjs)


df = read.csv('./data/covid_symptoms_table.csv', row.names=1)

ui = fluidPage(
  titlePanel("Covid 19 Symptoms"),
  p(
    "Data from: ",
    a(href="https://github.com/hms-dbmi/upset-altair-notebook", "Github")),
  selectInput('order', 'Sort Order', choices=   c(`1. Cardinality (desc), 2. Degree (asc), 3. Name` ="cardinality,degree,name",
                                                         `1. Cardinality (desc), 2. Name` ="cardinality,name",
                                                         `1. Degree (asc), 2. Cardinality (desc), 3. Name` ="degree,cardinality,name",
                                                         `1. Set, 2. Cardinality (desc), 3. Name` ="group,cardinality,name"
                                                         ),selected="cardinality,degree,name", width="50em"),
  upsetjsOutput("upsetjs1")
)


server = function(input, output, session) {
  # render upsetjs as interactive plot
  output$upsetjs1 <- renderUpsetjs({
    upsetjs() %>% 
      fromDataFrame(df) %>% 
      generateIntersections(order.by=unlist(strsplit(input$order, ",", T))) %>% 
      interactiveChart()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
