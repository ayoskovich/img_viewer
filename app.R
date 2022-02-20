# Run with this to show the code next to the app
# runApp("app.R", display.mode = "showcase")

library(shiny)
library(tidyverse)
library(lubridate)

ALL_FILES <- list.files('www', pattern='*.jpg|*.png')

ui <- fluidPage(
  #tags$head(
  #  tags$link(rel = 'stylesheet', type='text/css', href='mystyles.css')
  #),
  tabsetPanel(
    tabPanel('Tagger',
      titlePanel('Image Tagger'),
      mainPanel(
        selectInput('which_img', label='Image File', choices=ALL_FILES),
        selectInput('iso_tag', label='ISO', choices=c(100, 200, 400)),
        
        # Hacky way to remove whitespace around resized image
        HTML("<div style='height: 300px;'>"),
        imageOutput('show_image'),
        HTML("</div>"),
        
        actionButton('send', 'Update output file'),
        dataTableOutput('logdata')
      )
    )
  )
)
  
server <- function(input, output) {
    
    output$show_image <- renderImage({
        list(
            src=file.path(paste0('www/', input$which_img)),
            width='50%', height='50%'
        )
    })
    
    output$logdata <- renderDataTable({
      read_csv(
        'logfile.csv',
        col_types=cols(
          dt=col_datetime(),
          img=col_character(),
          iso=col_integer()
        )
      )
    })
    
    observeEvent(input$send, {
      read_csv(
        'logfile.csv',
        col_types=cols(
          dt=col_datetime(),
          img=col_character(),
          iso=col_integer()
        )
      ) %>% 
        bind_rows(
          tribble(
            ~dt, ~img, ~iso, 
            now(), input$which_img, as.integer(input$iso_tag)
          )
        ) %>% 
        write_csv('logfile.csv')
      
      showNotification(
        'Data updated!', 
        duration = 3, 
        closeButton = T,
        type='message'
      )
    })
}

shinyApp(ui = ui, server = server)