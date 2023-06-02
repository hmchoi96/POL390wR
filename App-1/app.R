library(shiny)
#define UI

ui <- fluidPage(
  
  titlePanel("titlePanel"),
  ## shiny generally follow javascript
  sidebarLayout( position = "left",
                 sidebarPanel("sidebarPanel",
                              fluidRow(
                                column(3,
                                h3("Buttons"),
                                actionButton("login", "Action"),
                                br(),
                                br(),
                                submitButton("signin")
                                )
                              ) 
                              ),
                 mainPanel(
                   h1("First level title"),
                   h2("Second level title"),
                   h6("Sixth level title", align = "center"),
                   p("p creates a paragraph of text. Supply a style attribute
                   to change the format of the entire paragraph,", style = "font-family: 'times'; font-si16pt"),
                   strong("strong() makes bold text."),
                   em("em() creates italicized text."),
                   br(),
                   code("code displays your text similar to computer code"),
                   div("div creates segments of text with a similar style.
                       This division of text is all blue because I passed the argument 'syle = color:blue' to div", style = "color:blue",
                       br(),
                       em("div can do this too")
                   ),
                   p("span does the same thing as div, but it works with",
                     span("groups of words", style = "color:red"),
                     "that appear inside a paragraph"),
                   img(src = "bird1.jpg", height = 72, width = 72),
                   br(),
                   fluidRow(
                   column(10,
                          h3("single checkbox"),
                          checkboxInput("checkbox", "Choice A", value = F)
                   ),
                   column(3,
                          checkboxGroupInput("checkGroup",
                                             h3("Checkbox group"),
                                             choices = list("Choice 1" = 1,
                                                            "Choice 2" = 2,
                                                            "Choice 3" = 3),
                                             selected = 1
                                             )
                          ),
                   column(3,
                          dateInput("date",
                                    h3("Date input"),
                                    value = "2023-06-01")
                          )
                 ),
                 fluidRow(
                   column(3,
                          dateRangeInput("dates", h3("Date range"))),
                   column(3,
                          fileInput("file", h3("File input"))),
                   column(3,
                          h3("Help text"),
                          helpText("Note help text isn't a true widget,",
                                   "but it provides an easy way to add text to",
                                   "accompany other widgets.")
                          ),
                   column(3,
                          numericInput("num",
                                       h3("Numeric input"),
                                       value =10)
                          )
                 ),
                 fluidRow(
                   column(3,
                          radioButtons("radio", h3("Radio buttons"),
                                       choices = list("Choice 1" = 1, "Choice 2" = 2,
                                                      "Choice 3" = 3, "Choice 4" = 4), selected =2)
                          ),
                   column(3,
                          sliderInput("slider1", h3("Sliders"),
                                      min = 0, max = 100, value = 50),
                          sliderInput("slider2", "",
                                      min = 0, max = 100, value = c(25, 75))
                          ),
                   column(3,
                          textInput("text", h3("Text input"),
                                    value = "enter text...")
                          )
                 )
                 )
  )
)
#define server logic
server <- function(input, output) {
  
}
#run the app
shinyApp(ui = ui, server = server)
