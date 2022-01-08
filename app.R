#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           img(src='myImage.jpg', align = "right")
        )
    ),
    
    fluidRow(
        sidebarPanel(
            uiOutput("select.folder"),
            uiOutput('select.file')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    root <- "C:/Users/anthony/Desktop/img_viewer"
    output$select.folder <-
        renderUI(expr = selectInput(inputId = 'folder.name',
                                    label = 'Folder Name',
                                    choices = list.dirs(path = root,
                                                        full.names = FALSE,
                                                        recursive = FALSE)))
    
    output$select.file <-
        renderUI(expr = selectInput(inputId = 'file.name',
                                    label = 'File Name',
                                    choices = list.files(path = file.path(root,
                                                                          input$folder.name))))
}

# Run the application 
shinyApp(ui = ui, server = server)
