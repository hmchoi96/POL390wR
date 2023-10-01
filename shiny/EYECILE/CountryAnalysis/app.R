

library(shiny)
## EYECILE research
## Country analysis
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Country analysis"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
        ),

        # Show a plot of the generated distribution
        mainPanel(
          fluidRow(
            helpText("Explore countries with thorough analysis"),
            selectInput("var",
                        label = "Choose a country you would like to explore",
                        choices = list("United States",
                                       "Japan"
                                       )
            )
          )
        )
    )
)
# Define server logic required to draw a histogram
server <- function(input, output) {

    
}

# Run the application 
shinyApp(ui = ui, server = server)
