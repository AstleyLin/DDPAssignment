shinyUI(
    pageWithSidebar(
        headerPanel("Stock price and technical index analysis"),
        sidebarPanel(width = 12,
            textInput(inputId="StockIndex", label="Stock ID", value="^TWII"),
            dateInput(inputId="LastDay", label="Lastest Day", value = NULL, min = NULL, max = NULL, 
                      format = "yyyy-mm-dd", startview = "month", weekstart = 0, language = "en"),
            numericInput(inputId="DuringDays", label="During Days", value=180, min = 60, max = 360, step = 30),
            actionButton(inputId="PlotKBox", label="Plot Chart")
        ),
        
        mainPanel(
            p('K-Box and Index Analysis'),
            plotOutput(outputId="KBoxPot", width = "1920px", height = "1080px")
        )  
    )
)
