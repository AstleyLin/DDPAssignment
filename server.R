library(shiny)
library(tseries)
library(zoo)
library(markdown)
source("StockTrendChart.Func.R")

shinyServer(
    function(input, output) {
        
        PushCounter <<- 1
        #data.ls <- reactive({})
        output$KBoxPot <- renderPlot({
            input$PlotKBox
            StockIndex <- isolate(input$StockIndex)
            DataTimeEnd <- isolate(input$LastDay)
            DuringDays <- isolate(as.numeric(input$DuringDays))
            DataTimeEnd <- strptime(paste(DataTimeEnd, "23:59:59"), "%Y-%m-%d %H:%M:%S")
            print(TimePeriod <- c(format(DataTimeEnd - DuringDays*24*60*60, "%y-%m-%d"), format(DataTimeEnd+1*24*60*60, "%y-%m-%d")))            
            data.df <- isolate(WebDB.Query.Stock(StockIndex=StockIndex, TimePeriod.vt=TimePeriod, TimeFormat.R="%y-%m-%d"))            
            title <- paste("Stock ID :", StockIndex)
            ReActChart <- reactive({Chart.Trend.Stock.KBox(data.df=data.df, Title=title)})
            if(input$PlotKBox == PushCounter) {
                ReActChart()
                PushCounter <<- PushCounter + 1
            }

        }, width = "auto", height = "auto")

    }
)
              
