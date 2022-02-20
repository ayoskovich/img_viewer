
shinyUI(dashboardPage(
  dashboardHeader(title = "Image Viewer"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Edit Tags", tabName = "tagger", icon = icon('tags')),
      menuItem("Photo Search", tabName = "viewer", icon = icon('search')),
      menuItem("About", tabName = "abt", icon = icon('info'))
    )
  ),
  dashboardBody(
    useShinyjs(),
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
        hidden(
          radioButtons("iso_tag", label = "ISO", choices = ISO_CHOICES)
        ),
        actionButton("send", "Update output file"),
        dataTableOutput("logdata"),
        actionButton('mybutt', 'Edit data'),
        br(),
        br(),
        uiOutput("show_image")
      ),
      
      tabItem(
        tabName = "viewer",
        h1("Search for images"),
        radioButtons("which_iso", label = "ISO", choices = ISO_CHOICES),
        uiOutput("myboxes")
      ),
      
      tabItem(
        tabName = 'abt',
        h1('About'),
        p('This is the about page.')
      )
    )
  )
))
