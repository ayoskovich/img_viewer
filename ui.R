
shinyUI(dashboardPage(
  dashboardHeader(title = "Image Tagger"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Edit Tags", tabName = "tagger", icon = icon("dashboard")),
      menuItem("Photo Search", tabName = "viewer", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "tagger",
        h1("Modify Tags"),
        selectInput(
          "filterSet",
          label = "Which files to view?",
          choices = c("All files", "Untagged")
        ),
        selectInput(
          "which_img",
          label = "Image File",
          choices = ALL_FILES
        ),
        radioButtons("iso_tag", label = "ISO", choices = ISO_CHOICES),

        # Hacky way to remove whitespace around resized image
        HTML("<div style='height: 250px;'>"),
        imageOutput("show_image"),
        HTML("</div>"),
        actionButton("send", "Update output file"),
        dataTableOutput("logdata")
      ),
      tabItem(
        tabName = "viewer",
        h1("Search for images"),
        radioButtons("which_iso", label = "ISO", choices = ISO_CHOICES),
        uiOutput("myboxes")
      )
    )
  )
))
