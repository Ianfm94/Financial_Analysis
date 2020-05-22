import yfinance as yf
from pandas_datareader import data as pdr

yf.pdr_override()

# Change ticker to whatever company you like
data = pdr.get_data_yahoo("^DJI")

# Add location to whatever folder you would like to save
# the csv file too
data.to_csv('Dow_Jones_data US Listing.csv')
