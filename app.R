# Run with this to show the code next to the app
# runApp("app.R", display.mode = "showcase")

library(shiny)
library(DT)
source('build_plot.R')

ALL_FILES <- list.files('www')
TAG_OPTIONS <- c(
  'funny',
  'not funny'
)

ui <- fluidPage(
    # Application title
  tabsetPanel(
    tabPanel('Edit tags',
      titlePanel('Image Viewer'),
      sidebarLayout(
          position = 'right',
          sidebarPanel(
              selectInput(
                  "file_options", 
                  label='Select a file',
                  choices = ALL_FILES
              ),
              selectInput(
                'tag1', 
                label = 'Add the tag here', 
                choices= TAG_OPTIONS
              ),
              actionButton('send', 'Click me!')
          ),
          mainPanel(
              imageOutput('show_image'),
              br(),
              dataTableOutput('mytable')
          )
      )
    ),
    tabPanel('Summary Stats',
      titlePanel('foo')
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
    
    output$mytable <- renderDataTable({
        make_img_table()
    }, escape=FALSE)
    
    output$show_image <- renderImage({
        list(
            src=file.path(paste0('www/', input$file_options)),
            width=150,
            height=150
        )
    })
    
    observeEvent(input$send, {
      print(paste0(
        input$file_options, ',', input$tag1
      ))
    })
}

shinyApp(ui = ui, server = server)
