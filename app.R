df=read.delim("Palabras.txt", sep=":",stringsAsFactors = F, encoding = "UTF-8", col.names = c("Palabras", "Definición"))
bl_sp=which(df[,2]=="")
for(i in bl_sp){
  df[i-1,2]=paste(df[i-1,2], df[i,1])
}
df=df[-bl_sp,]
# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)
library(shiny)

server <-function(input, output) {

  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- df
    if (input$pal != "All") {
      data <- data[data$Palabras == input$pal,]
    }
    data
  }))
  
}


ui <- fluidPage(
  titlePanel("Diccionario"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("pal",
                       "Palabra",
                       c("All",
                         unique(as.character(df$Palabras))))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)

shinyApp(ui = ui, server = server)
