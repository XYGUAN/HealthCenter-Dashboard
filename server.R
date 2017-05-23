library(shinydashboard)
source("DecisionTree.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$DecitionTree <- renderPlot({
    model.generation(input$state, model = "Tree", output = input$target)
  })
  
  output$Analysis <- renderPlot({
    model.generation.error(input$state.error, model = "Tree", output = input$target.error)
  })
  
  output$Condition <- renderTable({
    condition_temp <- unlist(strsplit(input$condition, " "))
    table.condition(input$state.table, condition_temp[1], condition_temp[2], condition_temp[3])
  })
  
})
