
shinyServer(function(input, output, session) {
  same_iso <- reactive({
    read_rds(LOG_FILE) %>%
      group_by(img) %>%
      filter(dt == max(dt)) %>%
      filter(iso == input$which_iso) %>%
      ungroup() %>%
      pull(img) %>%
      unique()
  })

  output$myboxes <- renderUI({
    v <- list()
    for (i in 1:length(same_iso())) {
      v[[i]] <- img(src = same_iso()[i], height = "150px")
    }

    v
  })

  output$show_image <- renderImage({
    list(
      src = file.path(paste0("www/", input$which_img)),
      width = "50%", height = "50%"
    )
  })

  thedatums <- reactive({
    read_rds(LOG_FILE) %>%
      filter(img == input$which_img)
  })

  output$logdata <- renderDataTable(
    {
      thedatums() %>%
        # Get most recent value
        filter(dt == max(dt)) %>%
        select(
          `Last Updated` = dt,
          `ISO` = iso
        ) %>%
        mutate(across(everything(), as.character)) %>%
        pivot_longer(
          everything(),
          names_to = "Variable",
          values_to = "Value"
        )
    },
    options = list(
      info = F,
      searching = F,
      ordering = F,
      paging = F,
      lengthChange = F
    )
  )

  # Modify tags and write to file
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
      "Data updated",
      duration = 3,
      closeButton = T,
      type = "message"
    )
  })

  tagged_files <- reactive({
    tibble(img = ALL_FILES) %>%
      left_join(read_rds(LOG_FILE)) %>%
      filter(is.na(dt)) %>%
      pull(img)
  })

  all_files <- reactive({
    tibble(img = ALL_FILES) %>%
      pull(img)
  })

  observeEvent(input$filterSet, {
    if (input$filterSet == "Untagged") {
      updateSelectInput(session, "which_img", choices = tagged_files())
    } else if (input$filterSet == "All files") {
      updateSelectInput(session, "which_img", choices = all_files())
    }
  })
})
