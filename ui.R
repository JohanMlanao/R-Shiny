#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# setwd("~/Travail/M1/S8/Projet d'expertise/Projet")

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Informations sur les campagnes"),

        sidebarPanel(
            selectInput("Choix_du_graphe","Choix du graphe",c("Evolution des campagnes" = 1,"Taux de campagne financees" = 2,"Montant moyen des campagnes financees" = 3)),
            selectInput("annee_debut",
                        "Annee de depart",
                        c(2010:2019)),
            selectInput("choix_du_mois",
                        "Choix du mois",
                        c("Janvier","Fevrier","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre")),
            selectInput("Categorie","Choix de la categorie",c("Art & Photo"= 1,"Artisanat & Cuisine " = 2,"Autres projets" = 3,"BD" = 4,"Edition & Journal." = 5,"Enfance & Educ." = 6,"Film et video" = 7,"Jeux" = 8,"Mode & Design" = 9,"Musique" = 10,"Patrimoine" = 11,"Sante & Bien-etre" = 12,"Solidaire & Citoyen" = 13,"Spectacle vivant" = 14,"Sports" = 15,"Technologie" = 16))),
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
          
        )
)
)
