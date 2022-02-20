library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyverse)
library(lubridate)

ALL_FILES <- list.files('www', pattern='*.jpg|*.png')
LOG_FILE <- 'logfile.rds'

ISO_CHOICES <- c(
  100,
  200,
  400
)