library(shiny)

shinyUI(fluidPage(
      titlePanel("Singapore Infectious Diseases Burden"),
        
      sidebarLayout(
            sidebarPanel(
                  h4("Background Information"),
                  p("The following list of infectious diseases is a subset of the diseases that are tracked by the Ministry of Health (MOH) of Singapore. By selecting the disease, you can see the corresponding graph showing the number of cases of the disease over the four years."),
                  checkboxGroupInput("checkbox",
                                     label = "Choose infectious disease(s):",
                                     choices = list("Dengue Fever" = "Dengue Fever",
                                                    "Hand, Foot, Mouth Disease" = "Hand, Foot, Mouth Disease",
                                                    "Salmonellosis" = "Salmonellosis",
                                                    "Mumps" = "Mumps",
                                                    "Campylobacter Enterosis" = "Campylobacter Enterosis",
                                                    "Viral Hepatitis A" = "Viral Hepatitis A"),
                                     selected = "Dengue Fever")),
            mainPanel(
                  h4("Infectious Disease Trends in Singapore 2012-2016"),
                  p("The data used to plot the interactive graph is obtained from the", 
                    a("MOH Weekly Infectious Diseases Bulletin", href = "https://www.moh.gov.sg/content/moh_web/home/statistics/infectiousDiseasesStatistics/weekly_infectiousdiseasesbulletin.html"), 
                    ". The", 
                    code(".csv"), 
                    "file is downloaded and loaded onto", 
                    code("R"),
                    ". A copy of the file that is used to plot this graph is also loaded onto GitHub for reference. The weekly bulletin is uploaded by MOH every week."),
                  p("Please wait a while for the graph to load from the server."),
                  plotOutput("plot1")
          )
  )
))
