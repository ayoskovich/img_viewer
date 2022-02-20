# Run with this to show the code next to the app
# runApp("app.R", display.mode = "showcase")

library(shiny)
library(tidyverse)
library(lubridate)

ALL_FILES <- list.files('www', pattern='*.jpg|*.png')
LOG_FILE <- 'logfile.rds'

ui <- fluidPage(
  #tags$head(
  #  tags$link(rel = 'stylesheet', type='text/css', href='mystyles.css')
  #),
  tabsetPanel(
    tabPanel('Tagger',
      titlePanel('Image Tagger'),
      mainPanel(
        selectInput('which_img', label='Image File', choices=ALL_FILES),
        radioButtons('iso_tag', label='ISO', choices=c(100, 200, 400)),
        
        # Hacky way to remove whitespace around resized image
        HTML("<div style='height: 250px;'>"),
        imageOutput('show_image'),
        HTML("</div>"),
        
        actionButton('send', 'Update output file'),
        dataTableOutput('logdata')
      )
    ),
    tabPanel('Search',
      titlePanel('Image Search'),
      mainPanel(
        radioButtons('which_iso', label='ISO', choices=c(100, 200, 400)),
        uiOutput('myboxes')
      )
    )
  )
)
  
server <- function(input, output) {
    
    IMG_LIST <- list('A.jpg', 'B.jpg')
    v <- list()
    for (i in 1:length(IMG_LIST)){
      v[[i]] <- img(src=IMG_LIST[i], height='150px')
    }
    
    output$myboxes <- renderUI(v)
    
    output$show_image <- renderImage({
        list(
            src=file.path(paste0('www/', input$which_img)),
            width='50%', height='50%'
        )
    })
    
    output$logdata <- renderDataTable(
      {
        read_rds(LOG_FILE) %>% 
          filter(img == input$which_img) %>% 
          filter(dt == max(dt)) %>% 
          select(
            `Last Updated` = dt,
            `ISO` = iso
          ) %>% 
          mutate(across(everything(), as.character)) %>% 
          pivot_longer(
            everything(),
            names_to='Variable',
            values_to='Value'
          )
      },
      options=list(
        info=F,
        searching=F,
        ordering=F,
        paging=F,
        lengthChange=F
      )
    )
    
    observeEvent(input$send, {
      read_rds(LOG_FILE) %>% 
        bind_rows(
          tribble(
            ~dt, ~img, ~iso, 
            now(), input$which_img, as.integer(input$iso_tag)
          )
        ) %>% 
        write_rds(LOG_FILE)
      
      showNotification(
        'Data updated', 
        duration = 3, 
        closeButton = T,
        type='message'
      )
    })
}

shinyApp(ui = ui, server = server)