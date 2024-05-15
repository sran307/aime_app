import streamlit as st
import pandas as pd
import numpy as np
# import tensorflow as tf
# from keras.models import load_model
import matplotlib.pyplot as plt
import yfinance as yf
from datetime import datetime

def main():
    st.title("Stock Price Prediction")

    # Fetch data
    end = datetime.now()
    start = datetime(end.year - 20, end.month, end.day)
    stock = "ITC.NS"
    google_data = yf.download(stock, start, end)

    # Load model
    # model = load_model("Latest_stock_price_model.keras")

    # Calculate moving average for 250 days
    google_data['MA_for_200_days'] = google_data.Close.rolling(200).mean()

    # Plot the graph
    st.write("### Google Stock Price with 250-Day Moving Average")
    fig = plot_graph(google_data['MA_for_200_days'], google_data)
    st.pyplot(fig)

def plot_graph(values, full_data):
    fig = plt.figure(figsize=(15, 16))
    plt.plot(values, "Orange")
    plt.plot(full_data.Close, 'b')
    return fig

if __name__ == "__main__":
    main()
