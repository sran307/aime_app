from django.http import JsonResponse
# from nsetools import Nse
from nsepython import *
from rest_framework.decorators import api_view
from rest_framework.response import Response
from urllib.request import build_opener, HTTPCookieProcessor
from .stock_details import stockDetails
from pprint import pprint
import yfinance as yf
from ..serializers import stockNameSerializer
from ..models import StockNames, TradeData, Holidays, SwingData
import pandas as pd
from datetime import datetime, timedelta, date
import math
from django.db import connection
from django.db.models import F, Subquery, OuterRef

@api_view(['GET'])
def getQuotes(request):
    stocks = nse_eq_symbols()
    for stock in stocks:
        stockData ={}
        stockData['stockCode'] = stock
        yCode = stock+'.NS'
        stockData['yCode'] = yCode
        q = nse_eq(stock)
        # for key, value in q['info'].items():
        #     if key == 'companyName':
        #         stockData['stockName'] = value
        
        company_name = q['info']['companyName']
        stockData['stockName'] = company_name
        stockName_serializer = stockNameSerializer(data = stockData)
        try:
            if stockName_serializer.is_valid():
                #stockName_serializer.save() 
                print('insertion is blocked')
        except Exception as e:
            print(str(e))  
                
        pprint(stockData)
    return Response({'status': 200})

@api_view(['GET'])
def getDailyData(request):
    current_date = datetime.now().date()
    for x in range(6):
        end_date = current_date- timedelta(days=x)
        dateExist = Holidays.objects.filter(holiday=end_date)
        if not dateExist.exists():
            break
        
    for x in range(6):
        start_date = end_date - timedelta(days=7+x)
        sDate = Holidays.objects.filter(holiday=start_date)
        if not sDate.exists():
            break
    for x in range(6):
        prev_date = end_date - timedelta(days=1+x)
        pDate = Holidays.objects.filter(holiday=prev_date)
        if not pDate.exists():
            break
        
    end_date = end_date+timedelta(days=1)
    end_date_str = end_date.strftime("%Y-%m-%d")
    start_date_str = start_date.strftime("%Y-%m-%d")
    
    dataExist = TradeData.objects.filter(updatedAt=current_date).exists()
    if not dataExist:
        tableName = 'trade_data'
        with connection.cursor() as cursor:
            cursor.execute("TRUNCATE TABLE {};".format(tableName))
        
        stocks = StockNames.objects.all()
        for stock in stocks:
            ticker_symbol = stock.yCode

            data = yf.download(ticker_symbol, start=start_date_str, end=end_date_str)            
            for index, row in data.iterrows():
                date = index
                open_price = row['Open']
                high_price = row['High']
                low_price = row['Low']
                close_price = row['Close']
                volume = row['Volume']
                adjClose = row['Adj Close']           
                stock_data = TradeData(date=date, 
                                       open=open_price, 
                                       high=high_price,
                                    low=low_price, 
                                    close=close_price, 
                                    volume=volume, 
                                    adjClose=adjClose, 
                                    stock=stock, 
                                    startDate=start_date, 
                                    endDate=end_date,
                                    prevDate = prev_date)
                stock_data.save()
                
    return Response({'status': 200})
    
@api_view(['GET'])  
def dataScreen(request):
    dataExist = SwingData.objects.exists()
    if dataExist:
        tableName = 'swing_data'
        with connection.cursor() as cursor:
            cursor.execute("TRUNCATE TABLE {};".format(tableName))
                
    current_date = datetime.now().date()
    for x in range(6):
        end_date = current_date- timedelta(days=x)
        dateExist = Holidays.objects.filter(holiday=end_date)
        if not dateExist.exists():
            break
        
    for x in range(6):
        start_date = end_date - timedelta(days=100+x)
        sDate = Holidays.objects.filter(holiday=start_date)
        if not sDate.exists():
            break
    
    end_date = end_date+timedelta(days=1) 
    end_date_str = end_date.strftime("%Y-%m-%d")
    start_date_str = start_date.strftime("%Y-%m-%d")
    
    firstData = TradeData.objects.filter(id=1).values()
    for data in firstData:
        target_date = data['endDate']
        date_1 = data['startDate']
        date_2 = data['prevDate']
        stocks = StockNames.objects.all()
        for stock in stocks:
            stock_id = stock.id

            query = """
                SELECT stock
                FROM trade_data
                WHERE `date` = %s
                AND `stock` = %s
                AND `close` > (
                    SELECT `close`
                    FROM trade_data 
                    WHERE `date` = %s
                    AND `stock` = %s
                )
                AND `close` > (
                    SELECT `close`
                    FROM trade_data 
                    WHERE `date` = %s
                    AND `stock` = %s
                )
                AND `close` > (
                    SELECT (`close` * 1.01)
                    FROM trade_data 
                    WHERE `date` = %s
                    AND `stock` = %s
                )
                AND `close` > 100
                AND `close` <= 200
                AND volume > 1000000;
            """

            with connection.cursor() as cursor:
                cursor.execute(query, [target_date, stock_id, date_1, stock_id, date_2, stock_id, date_2, stock_id])
                rows = cursor.fetchall()
            
                for stock in rows:
                    stocks = StockNames.objects.filter(id = stock[0]).values()
                    for stock in stocks:                       
                        ticker_symbol = stock['yCode']

                        data = yf.download(ticker_symbol, start=start_date_str, end=end_date_str)
                            
                        data['ema5'] = data['Close'].ewm(span=5, adjust=False).mean()
                        data['ema20'] = data['Close'].ewm(span=20, adjust=False).mean()
                        data['sma50'] = data['Close'].rolling(window=50).mean()
                        
                        for index, row in data.iterrows():
                            date = index
                            close_price = row['Close']    
                            ema5 = row['ema5']
                            ema20 = row['ema20']
                            if math.isnan(row['sma50']):
                                sma50 = 0
                            else:
                                sma50 = row['sma50']
                            # Create and save a new StockData object
                            swing_data = SwingData.objects.create(date=date,
                                                stock=StockNames.objects.get(pk=stock['id']), 
                                                startDate=start_date, 
                                                endDate=end_date-timedelta(days=1),
                                                ema5 = ema5,
                                                ema20 = ema20,
                                                sma50=sma50,
                                                close=close_price)
                            swing_data.save()
    latest_date = end_date-timedelta(days=1)     
    stockData = []
    swingStock = """ SELECT DISTINCT(stock) FROM swing_data;"""
    with connection.cursor() as cursor:
        cursor.execute(swingStock)
        rows = cursor.fetchall()
    unique_stocks = set(row[0] for row in rows)
    for stock in unique_stocks:
        procesQry = """
                        SELECT stock FROM swing_data
                WHERE `date` = %s
                AND stock = %s
                AND `close` >  (SELECT ema5 FROM swing_data WHERE date = %s AND stock = %s)
                AND `ema5` >  (SELECT ema20 FROM swing_data WHERE date = %s AND stock = %s)
                AND `ema20` >  (SELECT sma50 FROM swing_data WHERE date = %s AND stock = %s);
                """
        with connection.cursor() as cursor:
            cursor.execute(procesQry, [latest_date, stock, latest_date, stock,latest_date, stock, latest_date, stock])
            rows = cursor.fetchall()

            for data in rows:
                stock_instance = StockNames.objects.filter(id=data[0]).values()
                for stock in stock_instance:
                    stock_data = {
                        'id': stock['id'],
                        'stockName': stock['stockName'],
                        'stockCode': stock['stockCode'],
                        'yCode': stock['yCode'],
                    }
                stockData.append(stock_data)
            
    return Response({'status': 200, 'data':stockData}, 200)

@api_view(['GET'])
def getHolidays(request):
    year = date.today().year
    for month in range(1, 13):
        for day in range(1, 32):
            try:
                date_obj = date(year, month, day)
                if date_obj.weekday() == 6:  # Sunday: 6, Saturday: 5
                    dateExist = Holidays.objects.filter(holiday=date_obj)
                    if not dateExist.exists():
                        holidays = Holidays(holiday = date_obj, reason = 'sunday')
                        holidays.save()
                elif date_obj.weekday() == 5:
                    dateExist = Holidays.objects.filter(holiday=date_obj)
                    if not dateExist.exists():
                        holidays = Holidays(holiday = date_obj, reason = 'saturday')
                        holidays.save()                   
            except ValueError:
                pass
    
    nse_holiday = nse_holidays('trading')
    for item in nse_holiday['CBM']:
        trading_date = item['tradingDate']
        description = item['description']
        date_obj = datetime.strptime(trading_date, "%d-%b-%Y")
        dateExist = Holidays.objects.filter(holiday=date_obj)
        if not dateExist.exists():
            holidays = Holidays(holiday = date_obj, reason = description)
            holidays.save()
    return Response({'status': 200})