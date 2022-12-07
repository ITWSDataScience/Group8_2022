
rm(list=ls())   
library(tidyverse)
library(dplyr)
library(readxl)
library(glmnet)
library(reshape2)
library(ggplot2)
library(rpart)
library(Hmisc)
library(plotmo)
library("readxl")
library(reshape)
library(caret)
library(corrplot)

setwd("C:/Users/kevin/Downloads/data_merged.csv")
earn <- read.csv("data_merged.csv")
#str(earn)


df_init <- earn %>%
  select_if(is.numeric)

#source for code: https://r-coder.com/correlation-plot-r/
corrplot(cor(df_init),        # Correlation matrix
         method = "shade", # Correlation plot method
         mar=c(0,0,2,0),
         tl.cex=0.5,
         type = "lower",    # Correlation plot style (also "upper" and "lower")
         diag = TRUE,      # If TRUE (default), adds the diagonal
         tl.col = "black", # Labels color
         bg = "white",     # Background color
         title = "Data Variables Correlation Plot",       # Main title
         col = NULL)       # Color palette


hist(df_init$ALLSKY_KT)

boxplot(df_init$pm2.5, data=df_init, 
        ylab ="Amount (�g/m�)", xlab ="PM2.5",
        main = "Box Plot of PM2.5 Data")

boxplot(df_init$AOD_55, data=df_init, 
        ylab ="Amount", xlab ="AOD",
        main = "Box Plot of AOD Data")

boxplot(df_init$ALLSKY_SFC_LW_DWN, data=df_init, 
        ylab ="Irradiance (W/m^2)", xlab ="All Sky Surface Longwave Downward Irradiance",
        main = "Box Plot of All Sky Surface Longwave Downward Irradiance Data",
        cex.main = 0.8)


summary(df_init$pm2.5)
summary(df_init$AOD_55)
summary(df_init$ALLSKY_SFC_LW_DWN)

d <- density(df_init$pm2.5)
plot(d, main="Distribution of PM2.5 Values")

d <- density(df_init$AOD_55)
plot(d, main="Distribution of AOD Values")

d <- density(df_init$AOD_55)
plot(d)

newdata <- df_init$pm2.5[1:5000]
shapiro.test(newdata)

newdata <- df_init$AOD_55[1:5000]
shapiro.test(newdata)


d <- density(df_init$WD2M)
plot(d)

aqs = list()
for (x in 1:1000)
{
  y <- sample(1:length(earn$AQS_Site_ID), 1)
  aqs <- append(aqs, earn$AQS_Site_ID[y])
}

barplot(table(unlist(aqs)), las=2, cex.names=.5, 
        ylab ="Frequency", xlab ="Site number",
        main = "Frequency of Randomly Selected 1000 test sites")


