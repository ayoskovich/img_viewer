library(shiny)

ALL_FILES <- list.files('www')

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Image Viewer"),
    sidebarLayout(
        position = 'right',
        sidebarPanel(
            selectInput(
                "file_options", 
                label='Select a file',
                choices = ALL_FILES
            )
        ),
        mainPanel(
            code(textOutput('text')),
            br(), br(), br(),
            
            # App will search www/ for images
            img(src='car_smiling.jpg', height=500, width=500),
            dateRangeInput('dates', h3('Date Range')),
            br(), br(),
            textOutput('selected_date'),
            textOutput('selected_file')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$selected_date <- renderText({
        paste(
            'Start Date: ', input$dates[[1]],
            'End Date: ', input$dates[[2]]
        )
    })
    
    output$selected_file <- renderText({
        paste('You selected ', input$file_options)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)