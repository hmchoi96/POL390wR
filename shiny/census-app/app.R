## ch display reactive output

library(shiny)
# Load data
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)
# Source helper functions
source("helpers.R")

ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        helpText("Create demographic maps with",
                 "information from the 2010 US Census."),
        selectInput("var",
                    label = "Choose a variable to display",
                    choices = list("Percent White",
                                   "Percent Black",
                                   "Percent Hispanic",
                                   "Percent Asian"),
                    selected = "Percent White"
        ),
        sliderInput("range", h5("Range of interest : "  ),
                    min = 0, max = 100, value = c(0,100)
                    )
      )
    ),
    
    mainPanel(
      textOutput("selected_var"),
      textOutput("min_max"),
      plotOutput("map")
    )
  )
)
## run once each time a user visits the app
server <- function(input, output) {
  ## render* run each time a user change the value of a widget
  output$selected_var <- renderText({
    paste("You have selected", input$var)
  })
  output$min_max <- renderText({
    paste("You have chosen a range that goes from", input$range[1], "to", input$range[2])
  })
  output$map <- renderPlot({
    data <- switch (input$var,
      "Percent White" = counties$white,
      "Percent Black" = counties$black,
      "Percent Hispanic" = counties$hispanic,
      "Percent Asian" = counties$asian
    )
    color <- switch (input$var,
      "Percent White" = "black",
      "Percent Black" = "darkgreen",
      "Percent Hispanic" = "brown",
      "Percent Asian" = "darkblue"
    )
    legend <- switch (input$var,
      "Percent White" = "% White",
      "Percent Black" = "% Black",
      "Percent Hispanic" = "% Hispanic",
      "Percent Asian" = "% Asian"
    )
  percent_map(data, color, legend, input$range[1], input$range[2])
  })
  
}

# Run the application / run once when launch the app
shinyApp(ui = ui, server = server)
