library(shiny)
library(tidyverse)
library(lubridate)

ALL_FILES <- list.files('www', pattern='*.jpg|*.png')
LOG_FILE <- 'logfile.rds'

ISO_CHOICES <- c(
  100,
  200,
  400
)

shinyUI(fluidPage(
  tabsetPanel(
    tabPanel('Tagger',
      titlePanel('Image Tagger'),
      mainPanel(
        selectInput(
          'filterSet',
          label='Which files to view?',
          choices=c('All files', 'Untagged')
        ),
        selectInput(
          'which_img',
          label='Image File', 
          choices=ALL_FILES
        ),
        radioButtons('iso_tag', label='ISO', choices=ISO_CHOICES),
        
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
        radioButtons('which_iso', label='ISO', choices=ISO_CHOICES),
        uiOutput('myboxes')
      )
    )
  )
))