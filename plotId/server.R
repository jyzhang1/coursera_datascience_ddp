library(shiny)
library(readxl)
library(dplyr)
library(ggplot2)
library(reshape)

setwd("~/Data Science/Data Science Courses/09_DevelopingDataProducts/coursera_datascience_ddp/")
source("plotId/read_excel_allsheets.R")

# url <- "https://www.moh.gov.sg/content/dam/moh_web/Statistics/Healthcare_Institution_Statistics/More_Statistics.../Weekly%20infectious%20bulletin_cases.xls"
# fileDest <- "~/Data Science/Data Science Courses/09_DevelopingDataProducts/customApp/plotId/data/weekly_bulletin.xls"
# download.file(url, destfile = fileDest, method = "curl")

allSheets <- read_excel_allsheets("plotId/data/weekly_bulletin.xls")

dataID <- data.frame()

for (i in 1:length(allSheets)) {
      sheet <- data.frame(allSheets[[i]])
      sheet <- select(sheet, 
                      end = End,
                      dengue = contains("Dengue.Fever"), 
                      HFM = contains("Hand"),
                      salmonellosis = contains("Salmon"), 
                      mumps = contains("Mumps"),
                      campylo = contains("Campylo"),
                      hepa = contains("Hepatitis.A")
                      )
      dataID <- rbind(dataID, sheet)
}

valueNA <- c(which(is.na(dataID$end)), which(is.na(dataID$dengue)))
dataID <- dataID[-valueNA, ]
names(dataID) <- c("end",
                   "Dengue Fever",
                   "Hand, Foot, Mouth Disease",
                   "Salmonellosis",
                   "Mumps",
                   "Campylobacter Enterosis",
                   "Viral Hepatitis A")

shinyServer(function(input, output) {
      output$plot1 <- renderPlot({
            x <- input$checkbox
            colNumber <- c(1, match(x, names(dataID)))
            dataID2 <- select(dataID, colNumber)
            dataID2Names <- names(dataID2)[-1]
            dataID2Melt <- melt(dataID2, id.vars = "end")
            
            g <- ggplot(data = dataID2Melt, aes(x = end))
            g <- g + geom_line(aes(y = value, 
                                   color = variable), 
                               size = 1) +
                  scale_color_brewer(palette = "Set1", 
                                     "Infectious Disease") +
                  labs(x = "Year",
                       y = "Number of Cases") +
                  theme_gray(base_size = 16)
            print(g)
      })
})