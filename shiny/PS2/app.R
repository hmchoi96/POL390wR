getwd()
setwd("/Users/hyunmyungchoi/study_R/POL390/shiny/PS2")

library(shiny)
library(maps)
library(mapproj)

#election_results_42nd <- read.csv("2021_Canadian_Federal_Election_Results.csv")
#election_results_43rd <- read.csv("2019_Canadian_Federal_Election_Results.csv")
#election_results_44th <- read.csv("2021_Canadian_Federal_Election_Results.csv")
source("helper.R")
election_total <- rbind(election_results_42nd, election_results_43rd, election_results_44th)

#view(election_total)

ui <- fluidPage(

    # Application title
    titlePanel("Canadian Federal Election Results since Confederation"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          fluidRow(
            helpText("Create interactive graph with information from Federal Election"),
            selectInput("var",
                        label = "choose which year to create",
                        choices = list("Election on 2015",
                                       "Election on 2019",
                                       "Election on 2021"),
                        selected = "Election on 2015")
          )
        ),
    mainPanel(
      textOutput("selected_var"),
      
      plotOutput("winner")
    )
  )
)

server <- function(input, output) {
  output$selected_var <- renderText({
    paste("You have selected ", input$var, "year. Here is summary.")
  })
    
  output$winner <- renderPlot({
    year <- switch (input$var,
                    "Election on 2015" = election_results_42nd,
                    "Election on 2019" = election_results_43rd,
                    "Election on 2021" = election_results_44th)
    #winner(year)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
