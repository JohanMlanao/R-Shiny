#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# setwd("~/Travail/M1/S8/Projet d'expertise/Projet")

library(shiny)
library(tidyr)
library(lubridate)
library(dplyr)
library(ggplot2)

data <- read.csv2(file="data_ulule_2019.csv")

datanew <- subset(data,is_cancelled=="FALSE")

data2 <- subset(datanew,country=="FR"|country=="BE"|country==""|country=="IT"|country=="CA"|country=="ES"|country=="CH"|country=="DE")
data3 <- subset(data2,finished=="TRUE")

exchange_rate <- (data3$currency=="AUD")*0.57+(data3$currency=="BRL")*0.19+(data3$currency=="CAD")*0.65+(data3$currency=="CHF")*0.94+(data3$currency=="DKK")*0.13+(data3$currency=="EUR")+(data3$currency=="GBP")*1.12+(data3$currency=="NOK")*0.09+(data3$currency=="SEK")*0.092+(data3$currency=="USD")*0.9

data3$amount_raised <- data3$amount_raised*exchange_rate

data3$currency <- "EUR"


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
        output$distPlot <- renderPlot({
            list=c("Janvier","Fevrier","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre")
            
            if ( input$Choix_du_graphe== "Evolution_des_campagnes"){
            
            
            data_temp <- filter(data3, year(date_start) >= input$annee_debut,
                                month(date_start)==which(list==input$choix_du_mois))
            value <- as.data.frame(table(year(data_temp$date_start)))
            
            ggplot(value,aes(x=Var1,y=Freq)) +  geom_line(aes(group=1)) +
                geom_point(shape=21, color="black", fill="#69b3a2", size=6) 
            }
            else if(input$Choix_du_graphe== "Taux_de_campagne_financees"){
                
                data_finance <- (filter(data3,year(date_start)>=input$annee_debut,month(date_start)>=which(list==input$choix_du_mois),goal_raised==TRUE))
                value <- (filter(data3,year(date_start)>=input$annee_debut,month(date_start)>=which(list==input$choix_du_mois)))
                data_finance <- as.data.frame(table(year(data_finance$date_start)))
                value <- as.data.frame(table(year(value$date_start)))
                
                data_finance$Freq <- data_finance$Freq/value$Freq
                
                
                
                ggplot(data_finance,aes(x=Var1,y=Freq)) +  geom_line(aes(group=1)) +
                    geom_point(shape=21, color="black", fill="#69b3a2", size=6)
            }
            else{
                data_amount <- (filter(data3,year(date_start)>=input$annee_debut,month(date_start)>=which(list==input$choix_du_mois),goal_raised==TRUE))
                a <- as.numeric(input$annee_debut)
                montant_moyen <- rep(0,2019-a+1)
                for(i in a:2019){
                    temp <- which (year(data_amount$date_start)== i)
                    montant_moyen[i+1-a] <- mean(data_amount$amount_raised[temp])
                }
                annee <- seq(a,2019)
                montant_moyen <- cbind(annee,montant_moyen)
                montant_moyen <- as.data.frame(montant_moyen)
                montant_moyen <- na.omit(montant_moyen)
                ggplot(montant_moyen,aes(x =annee,y=montant_moyen)) + geom_bar(stat="identity")
        
            }
            
        })
    
}
)

