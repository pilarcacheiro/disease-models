######################################################################################################################
# IMPC Disease models Shiny app
# Current version DR11.0
# Latest update: 01/11/2022
######################################################################################################################

# Required packages

library(shiny)
library(DT)
library(tidyverse)
library(networkD3)


# Import datasets

allmodels <-  read.delim("data/dr11.gene.ortholog.model.disease.score.txt", stringsAsFactors = F, header=T, sep="\t") 

genesummary  <-  read.table("data/dr11.gene.summary.txt", stringsAsFactors = F, header=T, sep="\t")


######################################################################################################################


# Define UI for app 

ui <- fluidPage(
  
  # App title 
  
  titlePanel("IMPC disease models DR11.0"),
  
  # Sidebar layout with input and output definitions 
  
  sidebarLayout(
    
    # Sidebar panel for inputs 
    
    sidebarPanel(
      
      # Input: Choose dataset 
      
      selectInput("dataset", "Choose a dataset:",
                  choices = c("Mouse models disease table",
                              "Gene summary table")),
      
      selectInput("dataset2", "Choose a filter:",
                  choices = c("PhenoDigm match",
                              "No PhenoDigm match")),
      
      
      br(),
      
      # Download Button
      
      downloadButton("downloadData", "Download selected dataset"),
      
      
      br(),
      br(),
      br(),
      
      ## Action Button
      
      actionButton("showPlot", "Show Sankey diagram DR11.0 summary")
      
    ),
    
    # Main panel for displaying outputs 
    
    mainPanel(
      
      DT::dataTableOutput("table"),
      sankeyNetworkOutput("plot", width = "100%", height = "200%")
      
      
    )
    
  )
)

######################################################################################################################

# Define server logic to display and download selected file

server <- function(input, output) {
  
  filtered_title_type <- reactive({
    if (input$dataset == "Mouse models disease table" &
        input$dataset2 == "PhenoDigm match")  {
      return( allmodels %>% filter (phenodigm_match == "Y"))
    }
    
    if (input$dataset == "Mouse models disease table" &
        input$dataset2 == "No PhenoDigm match")  {
      return(allmodels %>% filter (phenodigm_match == "N"))
    }
    
    
    if (input$dataset == "Gene summary table" &
        input$dataset2 == "PhenoDigm match")  {
      return(genesummary %>% filter (any_phenodigm_match == "Y"))
    }
    
    
    if (input$dataset == "Gene summary table" &
        input$dataset2 == "No PhenoDigm match")  {
      return(genesummary %>% filter (any_phenodigm_match == "N"))
    }
    
  })
  
  # Table of selected dataset
  
  output$table <- DT::renderDataTable({
    filtered_title_type()
  })
  
  
  
  # Plot based on action button 
  
  
  output$plot <- renderSankeyNetwork({
    
    if (input$showPlot == 0)
      return()
    
    
    links = data.frame(source=c("Disease genes (1,706)", "Disease genes (1,706)", "HPO annotations (1,590)", 
                               "HPO annotations (1,590)"), 
                      target=c("No HPO annotations (116)", "HPO annotations (1,590)","PhenoDigm match (715)",
                               "No PhenoDigm match (875)"), 
                      value=c(116, 1590, 715, 875))
    
    nodes = data.frame(name=c(as.character(links$source), as.character(links$target)) %>% unique())
    links$IDsource = match(links$source, nodes$name)-1 
    links$IDtarget = match(links$target, nodes$name)-1
    
    nodes$group = factor(nodes$name,levels = c("Disease genes (1,706)", "No HPO annotations (116)",
                                               "HPO annotations (1,590)",
                                               "PhenoDigm match (715)", "No PhenoDigm match (875)"))
    nodes$name = factor(nodes$name,levels = c("Disease genes (1,706)", "No HPO annotations (116)",
                                              "HPO annotations (1,590)",
                                              "PhenoDigm match (715)", "No PhenoDigm match (875)"))
    
    links$group = as.factor(c("my_unique_group"))
    
    
    my.color.connections =  'd3.scaleOrdinal() .domain(["Disease genes (1,706)", "HPO annotations (1,590)",
    "PhenoDigm match (715)", "No HPO annotations (116)","No PhenoDigm match (875)","PhenoDigm match (715)"]) .
    range(["lightgrey","#56B4E9","#0072B2","#D55E00","#009E73" ])'
    
    
    sankeyNetwork(Links = links, Nodes = nodes, Source = "IDsource", Target = "IDtarget", 
                  Value = "value", NodeID = "name", 
                  colourScale = my.color.connections, nodePadding = 15,
                  LinkGroup = "group", NodeGroup = "group",
                  fontSize = 10, fontFamily = "Arial",
                  nodeWidth = 50, sinksRight = FALSE)
    
  })
  
  
  # Downloadable csv of selected dataset 
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, "-", input$dataset2, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(filtered_title_type(), file, row.names = FALSE)
    }
  )
  
}


######################################################################################################################

# Create Shiny app 

shinyApp(ui, server)

######################################################################################################################
