library(shiny)

ALL_FILES <- list.files('www', pattern='*.jpg|*.png')
LOG_FILE <- 'logfile.rds'

shinyServer(function(input, output, session) {
    
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
    
    output$logdata <- renderDataTable({
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
    
    tagged_files <- reactive({
      tibble(img = ALL_FILES) %>% 
        left_join(read_rds(LOG_FILE)) %>% 
        filter(is.na(dt)) %>% 
        pull(img)
    })
    
    observeEvent(input$filterSet, {
      if (input$filterSet == 'Untagged'){
        updateSelectInput(session, 'which_img', choices=tagged_files())
      } 
    })
})