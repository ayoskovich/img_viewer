# Run with this to show the code next to the app
# runApp("app.R", display.mode = "showcase")

library(shiny)
library(DT)

ALL_FILES <- list.files('www', pattern='*.jpg|*.png')

ui <- fluidPage(
  tags$head(
    tags$link(rel = 'stylesheet', type='text/css', href='mystyles.css')
  ),
  tabsetPanel(
    tabPanel('Tagger',
      titlePanel('Image Tagger'),
      mainPanel(
        selectInput('which_img', label='Image File', choices=ALL_FILES),
        selectInput('iso_tag', label='ISO', choices=c(100, 200, 400)),
        imageOutput('show_image'),
        actionButton('send', 'Click me!')
      )
    )
  )
)
  
server <- function(input, output) {
    
    output$show_image <- renderImage({
        list(
            src=file.path(paste0('www/', input$which_img)),
            width=150,
            height=150
        )
    })
    
    observeEvent(input$send, {
      print(input$which_img)
    })
}

shinyApp(ui = ui, server = server)