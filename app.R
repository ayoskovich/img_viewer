# Run with this to show the code next to the app
# runApp("app.R", display.mode = "showcase")

library(shiny)
source('build_plot.R')

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
            
            # App will search www/ for images
            img(src='car_smiling.jpg', height=200, width=200),
            
            dateRangeInput('dates', h3('Date Range')),
            br(), br(),
            
            textOutput('selected_date'),
            textOutput('selected_file'),
            br(), br(),
            plotOutput('cars_plot')
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
    
    output$cars_plot <- renderPlot({
        make_cars()
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)