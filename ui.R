library(shinydashboard)
source("DecisionTree.R")

dashboardPage(
  dashboardHeader(title = "Health Center"),
  
  dashboardSidebar(sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Analysis", tabName = "analysis", icon = icon("th")),
    menuItem("Exploration", tabName = "explore", icon = icon("cog"))
  )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
             fluidRow(
               box(
                 title = "Controls",
                 selectInput("state", "Please choose the state:", states.names),
                 selectInput("target", "Please choose the target variable:", output.variables)
               ),
               box(plotOutput("DecitionTree"),width = 10)
               
             )
    ),
    tabItem(tabName = "analysis",
             fluidRow(
               box(
                 title = "Controls",
                 selectInput("state.error", "Please choose the state:", states.names),
                 selectInput("target.error", "Please choose the target variable:", output.variables)
               ),
               box(plotOutput("Analysis"),width = 10)
               
             )
      
    ),
    tabItem(tabName = "explore",
            fluidRow(
              box(
                title = "Controls",
                selectInput("state.table", "Please choose the state:", states.names),
                textInput("condition", "Please type the condition, use , to seperate")
              ),
              box(tableOutput("Condition"))
            ))
    )
    
  )
)

