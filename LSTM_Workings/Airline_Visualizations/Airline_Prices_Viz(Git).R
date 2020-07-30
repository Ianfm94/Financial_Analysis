rm(list=ls())

library(purrr);  library(ggplot2); library(dplyr)
library(plotly); library(tibble); library(scales)

airline_prices = read.csv('Combined_Price_Data.csv',
                          header = T, fileEncoding = "UTF-8-BOM")
attach(airline_prices)

New_Date = as.Date(New_Date)

color_table = tibble(
  Airline_Name = c("American_Airlines", "Delta_Airlines",
                   "Southwest_Airlines", "United_Airlines"),
  Airline_Color = c("#93a6ad", "#c8102e",
                    "#F9B612", "#005daa")
)

prices_df = data.frame(y = Trading_Hrs_Return, 
                       x = New_Date, z = Class_,
                       stringsAsFactors = F)

prices_df$z = factor(prices_df$z, levels = color_table$Airline_Name)

names(prices_df)[names(prices_df)=="x"] = "Date"
names(prices_df)[names(prices_df)=="y"] = "Daily_RoR_during_trading_hours"
names(prices_df)[names(prices_df)=="z"] = "Airline"

y_vals = c(-20, -10, -5, 0,
           5, 10, 20)

plot_prices_1 = ggplot(prices_df, 
                       aes(x = Date, y = Daily_RoR_during_trading_hours,
                           color = Airline)) +
  geom_line() +
  labs(title = "US Airline Stock Price Rate of Returns",
       y = "Daily RoR % (during trading hours)",
       x = "Date") +
  scale_color_manual(values = color_table$Airline_Color) +
  theme_bw() + 
  scale_y_continuous(breaks = y_vals) +
  scale_x_date(date_breaks = "months", date_labels = "%b-%y") +
  theme(plot.title = element_text(size = 14,
                                  face = "bold",
                                  color = "black",
                                  hjust = 0.5),
        axis.text.x = element_text(angle=45, hjust = 1))

(int_plot = ggplotly(plot_prices_1))

htmlwidgets::saveWidget(as_widget(int_plot),
                        "US Airline Price RoR's.html")

# Part 2 (After Hours Trades)

prices_df_2 = data.frame(y = Total_Return, 
                         x = New_Date, z = Class_,
                         stringsAsFactors = F)

prices_df_2$z = factor(prices_df_2$z,
                       levels = color_table$Airline_Name)

names(prices_df_2)[names(prices_df_2)=="x"] = "Date"
names(prices_df_2)[names(prices_df_2)=="y"] = "Daily_RoR_including_after_hours_trades"
names(prices_df_2)[names(prices_df_2)=="z"] = "Airline"

plot_prices_2 = ggplot(prices_df_2, 
                       aes(x = Date, 
                           y = Daily_RoR_including_after_hours_trades,
                           color = Airline)) +
  geom_line() +
  labs(title = "US Airline Stock Price Rate of Returns",
       y = "Daily RoR %",
       x = "Date") +
  scale_color_manual(values = color_table$Airline_Color) +
  theme_bw() + 
  scale_x_date(date_breaks = "months", date_labels = "%b-%y") +
  theme(plot.title = element_text(size = 14,
                                  face = "bold",
                                  color = "black",
                                  hjust = 0.5),
        axis.text.x = element_text(angle=45, hjust = 1))

(int_plot_2 = ggplotly(plot_prices_2))

htmlwidgets::saveWidget(as_widget(int_plot_2),
                        "US Airline Price RoR's including after hours trades.html")

# Part 3 (Difference Graph)

prices_df_3 = data.frame(y = Difference, 
                         x = New_Date, z = Class_,
                         stringsAsFactors = F)

prices_df_3$z = factor(prices_df_3$z,
                       levels = color_table$Airline_Name)

names(prices_df_3)[names(prices_df_3)=="x"] = "Date"
names(prices_df_3)[names(prices_df_3)=="y"] = "Daily_RoR_Difference"
names(prices_df_3)[names(prices_df_3)=="z"] = "Airline"

plot_prices_3 = ggplot(prices_df_3, 
                       aes(x = Date, y = Daily_RoR_Difference,
                           color = Airline)) +
  geom_line() +
  labs(title = "US Airline Stock Price Rate of Return Difference",
       y = "Daily RoR Difference %",
       x = "Date") +
  scale_color_manual(values = color_table$Airline_Color) +
  theme_bw() + 
  scale_x_date(date_breaks = "months", date_labels = "%b-%y") +
  theme(plot.title = element_text(size = 14,
                                  face = "bold",
                                  color = "black",
                                  hjust = 0.5),
        axis.text.x = element_text(angle=45, hjust = 1))

(int_plot_3 = ggplotly(plot_prices_3))

htmlwidgets::saveWidget(as_widget(int_plot_3),
                        "Difference between Trading Hours and After Hours RoR's.html")