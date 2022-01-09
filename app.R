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
            br(),
            uiOutput('foo')
        )
    )
)
  
server <- function(input, output) {
    
    output$cars_plot <- renderPlot({
        # Example of using an external script
        # Would call in ui() with
        # plotOutput('cars_plot')
        make_cars(input$file_options)
    })
    
    output$foo <- renderUI({
        make_img_table()
    })
    
    output$show_image <- renderImage({
        list(
            src=file.path(paste0('www/', input$file_options))
            #width=1500,
            #height=1500
        )
    })
}

shinyApp(ui = ui, server = server)