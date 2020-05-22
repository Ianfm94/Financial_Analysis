rm(list=ls())

# In this file, I will firstly create an interactive graph 
# of the DJIA closing prices over the last thirty odd years.
# Secondly, I will create another interactive graph of the
# Daily Rates of Return of this index.

## Part 1, create closing price IG

# Required packages, you might need to install these
library(ggplot2)
library(dplyr)
library(plotly)
library(hrbrthemes)

# Need to change date data in below csv file, open excel file in folder.
# Once file is open, go to column I "New_Date", change date to format 'YYYY-MM-DD' 
# before continuing. Save and close the file

# DJIA Data saved in Github folder
DJIA = read.csv('Dow_Jones_data US Listing.csv',
                 header=T, fileEncoding = "UTF-8-BOM")
attach(DJIA)

# I always take a gander at the data first
View(DJIA)

# Fix date format or else won't plot, it gives the dreaded
# non-numeric argument to binary operator error (#fun)
New_Date = as.Date(New_Date)

DJIA_df = data.frame(y = Close, 
                      x = New_Date,
                      stringsAsFactors = F)

plot_DJIA = ggplot(DJIA_df, 
       mapping = aes(x = New_Date, y = Close))+
  geom_area(fill="#69b3a2", alpha=0.5) +
  geom_line(color="#69b3a2") +
  labs(title = "Dow Jones Industrial Average",
       y = "Closing Price ($)",
       x = "Year") +
  theme_ipsum()

# Create Interactive Graph
plot_DJIA = ggplotly(plot_DJIA)

# View IG
plot_DJIA

# Export Snazzy Interactive Graph
htmlwidgets::saveWidget(as_widget(plot_DJIA), "DJIA Closing Price.html")

## Part 2, create Daily RoR IG

DJIA_df_2 = data.frame(y = Daily_RoR, 
                     x = New_Date,
                     stringsAsFactors = F)
New_Date = as.Date(New_Date)

plot_DJIA_1 = ggplot(DJIA_df, 
                   mapping = aes(x = New_Date, y = New_RoR))+
  geom_area(fill="#69b3a2", alpha=0.5) +
  geom_col(color="#69b3a2") +
  labs(title = "Dow Jones Industrial Average",
       y = "Daily RoR %",
       x = "Year") +
  # The two below horizontal lines indicate the +/- 
  # 5% Daily RoR mark
  geom_hline(yintercept = 5,lty=2) +
  geom_hline(yintercept = -5, lty=2) +
  theme_ipsum()

plot_DJIA_1 = ggplotly(plot_DJIA_1)
plot_DJIA_1

htmlwidgets::saveWidget(as_widget(plot_DJIA_1), "DJIA Daily RoR.html")