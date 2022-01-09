# Run with this to show the code next to the app
# runApp("app.R", display.mode = "showcase")

library(shiny)
source('build_plot.R')

ALL_FILES <- list.files('www')

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
            imageOutput('show_image'),
            
            br(), br(),
            plotOutput('cars_plot')
        )
    )
)

server <- function(input, output) {
    
    output$selected_file <- renderText({
        paste('You selected ', input$file_options)
    })
    
    output$cars_plot <- renderPlot({
        make_cars(input$file_options)
    })
    
    output$show_image <- renderImage({
        list(
            src=file.path(paste0('www/', input$file_options)),
            width=300,
            height=300
        )
    })
}

shinyApp(ui = ui, server = server)