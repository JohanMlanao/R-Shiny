#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

setwd("~/Travail/M1/S8/Projet d'expertise/Projet")

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Informations sur les campagnes"),

        sidebarPanel(
            selectInput("Choix_du_graphe","Choix du graphe",c("Evolution_des_campagnes","Taux_de_campagne_financees","Montant_moyen_des_campagnes_financees")),
            selectInput("annee_debut",
                        "Annee de depart",
                        c(2010:2019)),
            selectInput("choix_du_mois",
                        "Choix du mois",
                        c("Janvier","Fevrier","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre"))),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
          
        )
)
)
