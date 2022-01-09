library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),
    sidebarLayout(
        position = 'right',
        sidebarPanel(
            uiOutput("select.folder"),
            uiOutput('select.file'),
        ),
        mainPanel(
            code(textOutput('text')),
            br(), br(), br(),
            
            # App will search www/ for images
            img(src='car_smiling.jpg', height=500, width=500),
            dateRangeInput('dates', h3('Date Range')),
            br(), br(),
            textOutput('selected_date')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    root <- "C:/Users/anthony/Desktop/img_viewer"
    
    output$text <- renderText({input$file.name})
    
    output$select.folder <- renderUI(expr = selectInput(
        inputId = 'folder.name',
        label = 'Folder Name',
        choices = list.dirs(path = root, full.names = FALSE, recursive = FALSE)
    ))
    
    output$select.file <- renderUI(expr = selectInput(
            inputId = 'file.name',
            label = 'File Name',
            choices = list.files(path = file.path(root, input$folder.name))
    ))
    
    output$selected_date <- renderText({
        paste(
            'Start Date: ', input$dates[[1]],
            'End Date: ', input$dates[[2]]
        )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)