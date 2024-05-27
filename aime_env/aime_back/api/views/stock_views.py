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
from ..models import StockNames, TradeData, Holidays, SwingData, StockCodes, StockRatios, StockHoldings
import pandas as pd
from datetime import datetime, timedelta, date
import math
from django.db import connection
from django.db.models import F, Subquery, OuterRef
import requests
from bs4 import BeautifulSoup
from django.db.models import Q


def fetch_with_retries(func, *args, retries=3, delay=5, **kwargs):
    """Helper function to retry a function call with a delay."""
    for i in range(retries):
        try:
            return func(*args, **kwargs)
        except requests.exceptions.RequestException as e:
            print(f"Attempt {i + 1} failed with error: {e}")
            time.sleep(delay)
    raise Exception(f"All {retries} attempts failed.")

def fetch_yf_ticker(yCode):
    """Fetch Yahoo Finance ticker information and raise an exception if it fails."""
    try:
        yStock = yf.Ticker(yCode)
        info = yStock.info
        return info
    except Exception as e:
        raise requests.exceptions.RequestException(f"Failed to fetch Yahoo Finance data for {yCode}: {e}")

@api_view(['GET'])
def getStockCode(request):
    """
    THIS FUNCTION IS USED TO TAKE ALL THE STOCKS LISTED IN NSE
    """
    try:
        stocks = fetch_with_retries(nse_eq_symbols)
    except Exception as e:
        return Response({'status': 500, 'error': 'Failed to fetch stock symbols', 'details': str(e)})

    for stock in stocks:
        try:
            StockCodes.objects.get(stockCode=stock)
            print(f"Stock {stock} already exists in the database.")
        except StockCodes.DoesNotExist:
            stock_code = StockCodes(stockCode=stock)
            stock_code.save()
    return Response({'status': 200})

@api_view(['GET'])
def getStockName(request):
    """
    THIS FUNCTION IS USED TO TAKE ALL THE STOCK Name
    """
    try:
        stocks = StockCodes.objects.filter(isUsed=False).values()
    except Exception as e:
        return Response({'status': 500, 'error': 'Failed to fetch stock symbols', 'details': str(e)})

    for stock in stocks:
        stock = stock['stockCode']
        try:
            StockNames.objects.get(stockCode=stock)
            print(f"Stock {stock} already exists in the database.")
        except StockNames.DoesNotExist:
            stockData = {'stockCode': stock, 'yCode': stock + '.NS', 'isActive':False}
            try:
                q = fetch_with_retries(nse_eq, stock)
            except Exception as e:
                print(f"Failed to fetch NSE data for {stock}: {e}")
                continue
            stockData['stockName'] = q['info']['companyName']
            stockData['isFno'] = q['info']['isFNOSec']
            
            stockName_serializer = stockNameSerializer(data=stockData)
            try:
                if stockName_serializer.is_valid():
                    stockName_serializer.save()
                    stockCodeUpt = StockCodes.objects.filter(stockCode=stock).update(isUsed=True)
                    print(f"Inserted new stock: {stockData['stockName']}")
                else:
                    print(f"Serializer errors for {stock}: {stockName_serializer.errors}")
            except Exception as e:
                print(f"Failed to save stock {stock}: {e}")
            
    return Response({'status': 200})

@api_view(['GET'])
def getQuotes(request):
    
    """
        THIS FUNCTION IS USED TO TAKE ALL THE STOCKS LISTED IN NSE. BUT I USE A FILTER FOR THIS,
        1. EARNINGS PER SHARE > 0
        2. RETURN ON EQUITY > 0
        3. TOTAL REVENUE > 0
        4. NET PROFIT MARGIN > 0
        5. DEBT TO EQITY < 1
        6. MARKET CAPITALIZATION > 1000CR
    """
    try:
        stocks = StockNames.objects.filter(isActive=False).values()
    except Exception as e:
        return Response({'status': 500, 'error': 'Failed to fetch stock symbols', 'details': str(e)})

    for stock in stocks:
        stockCode = stock['stockCode']
        try:
            yCode = stock['yCode']
            yStock = yf.Ticker(yCode)
            info = yStock.info
             
            if (
                info.get('trailingEps', -1) > 0 and
                info.get('returnOnEquity', -1) > 0 and
                info.get('totalRevenue', -1) > 0 and
                info.get('profitMargins', -1) > 0 and
                (info.get('debtToEquity', -1) / 100) < 1 and
                info.get('marketCap', -1) > 10000000000
            ):
                stockCodeUpt = StockNames.objects.filter(stockCode=stockCode).update(
                                industry=info.get('industry', -1),
                                sector=info.get('sector', -1),
                                isActive=True
                            )
                print(f"Updated stock: {stock['stockName']}")
            else:
                stockCodeUpt = StockNames.objects.filter(stockCode=stockCode).update(
                            isActive=False
                        )
                print(f"Stock {stock} did not meet the criteria.")           
        except Exception as e:
            print(f"Failed to update stock {stockCode}: {e}")
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
        start_date = end_date - timedelta(days=8+x)
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
        
        stocks = StockNames.objects.filter(Q(isActive=True) | Q(isFno=True))
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
                                    endDate=end_date-timedelta(days=1),
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
                AND `close` > (
                    SELECT `open`
                    FROM trade_data 
                    WHERE `date` = %s
                    AND `stock` = %s
                )
                AND `close` > 100
                AND `close` <= 200
                AND volume > 1000000;
            """

            with connection.cursor() as cursor:
                cursor.execute(query, [target_date, stock_id, date_1, stock_id, date_2, stock_id, date_2, stock_id, date_2, stock_id])
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

@api_view(['GET'])
def GetFundas(request):
    stocks = StockNames.objects.filter(Q(isActive=True) | Q(isFno=True))
    for stock in stocks:
        slug = stock.stockSlug
        url = 'https://www.tickertape.in/'+slug

        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }

        try:
            # Make a request to fetch the page content
            response = requests.get(url, headers=headers)
            response.raise_for_status()  # Check if the request was successful

            # Parse the page content
            soup = BeautifulSoup(response.content, 'html.parser')

            # Write the parsed HTML content to a file
            # with open('soup_content.html', 'w', encoding='utf-8') as file:
            #     file.write(str(soup))

            # Find the <script> tag with id="__NEXT_DATA__"
            script_tag = soup.find('script', id='__NEXT_DATA__', type='application/json')
            
            if script_tag:
                # Extract and parse the JSON content
                json_content = json.loads(script_tag.string)
                # with open('ticker.json', 'w', encoding='utf-8') as file:
                #     file.write(str(json_content))

                # Navigate to the 'ratios' object
                ratios = json_content.get('props', {}).get('pageProps', {}).get('securityInfo', {}).get('ratios', {})
                quotes = json_content.get('props', {}).get('pageProps', {}).get('securityQuote', {})
                holdings = json_content.get('props', {}).get('pageProps', {}).get('securitySummary', {}).get('holdings',{}).get('holdings',{})
                # Extract the required attributes
                stock_json, created = StockRatios.objects.update_or_create(stock=stock.id, defaults={
                    'stock':StockNames.objects.get(pk=stock.id),
                    'risk': ratios.get('risk'),
                    'm3AvgVol': ratios.get('3mAvgVol'),
                    'wpct_4': ratios.get('4wpct'),
                    'w52High': ratios.get('52wHigh'),
                    'w52Low': ratios.get('52wLow'),
                    'wpct_52': ratios.get('52wpct'),
                    'beta': ratios.get('beta'),
                    'bps': ratios.get('bps'),
                    'divYield': ratios.get('divYield'),
                    'eps': ratios.get('eps'),
                    'inddy': ratios.get('inddy'),
                    'indpb': ratios.get('indpb'),
                    'indpe': ratios.get('indpe'),
                    'marketCap': ratios.get('marketCap'),
                    'mrktCapRank': ratios.get('mrktCapRank'),
                    'pb': ratios.get('pb'),
                    'pe': ratios.get('pe'),
                    'roe': ratios.get('roe'),
                    'nShareholders': ratios.get('nShareholders'),
                    'lastPrice': ratios.get('lastPrice'),
                    'ttmPe': ratios.get('ttmPe'),
                    'marketCapLabel': ratios.get('marketCapLabel'),
                    'm12Vol': ratios.get('12mVol'),
                    'mrktCapf': ratios.get('mrktCapf'),
                    'apef': ratios.get('apef'),
                    'pbr': ratios.get('pbr'),
                    'etfLiq': ratios.get('etfLiq'),
                    'etfLiqLabel': ratios.get('etfLiqLabel'),
                    'dayChange' : quotes.get('dyChange'),
                    'weekChange' : quotes.get('wkChange'),
                    'monthChange' : quotes.get('mnChange'),
                    'away52H' : quotes.get('away52wH'),
                    'away52L' : quotes.get('away52wL'),
                    'volumeBreakOut' : quotes.get('volBreakout'),
                    'isCrossedHigh' : quotes.get('crossedHigh'),
                    'isCrossedLow' : quotes.get('crossedLow')
                })

                # If the record already existed and was updated, print a message
                if not created:
                    print("Existing record updated.")
                else:
                    print("Data inserted")

                for entry in holdings:
                    date_str = entry['date'].replace(' ', '')  # Remove any extra spaces
                    date_obj = datetime.strptime(date_str, '%Y-%m-%dT%H:%M:%S.%fZ').date()
                    holding = entry['data']
                    created = StockHoldings.objects.get_or_create(
                        date=date_obj,
                        stock=stock.id,
                        defaults={
                            'stock':StockNames.objects.get(pk=stock.id),
                            'date':date_obj,
                            'pmPctT': holding.get('pmPctT'),
                            'pmPctP': holding.get('pmPctP'),
                            'plPctT': holding.get('plPctT'),
                            'uPlPctT': holding.get('uPlPctT'),
                            'mfPctT': holding.get('mfPctT'),
                            'isPctT': holding.get('isPctT'),
                            'diPctT': holding.get('diPctT'),
                            'othDiPctT': holding.get('othDiPctT'),
                            'othExInsDiPctT': holding.get('othExInsDiPctT'),
                            'fiPctT': holding.get('fiPctT'),
                            'rhPctT': holding.get('rhPctT'),
                            'othPctT': holding.get('othPctT'),
                            'rOthPctT': holding.get('rOthPctT'),
                        }
                    )

                    if created:
                        print(f"Data inserted for date {date_obj}")
                    else:
                        print(f"Data exists {date_obj}")

                
            else:
                return JsonResponse({'status': 'error', 'message': 'Script tag with id "__NEXT_DATA__" not found.'})

        except requests.exceptions.RequestException as e:
            print(f"An error occurred: {e}")
        
    return Response({'status': 200})

@api_view(['GET'])
def GetSlug(request):
    filter = ['a', 'b', 'c', 'd', 'e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','others']
    for i in filter:
        url = 'https://www.tickertape.in/stocks?filter='+i
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }

        try:
            response = requests.get(url, headers=headers)
            response.raise_for_status()

            soup = BeautifulSoup(response.content, 'html.parser')

            script_tag = soup.find('script', id='__NEXT_DATA__', type='application/json')
                
            if script_tag:
                # Extract and parse the JSON content
                json_content = json.loads(script_tag.string)
                data = json_content.get('props', {}).get('pageProps', {}).get('index', {})
                for stock in data:
                    stockCodeUpt = StockNames.objects.filter(stockCode=stock['ticker']).update(
                                stockSlug=stock['slug']
                            )
                print('ticker updated')
        except requests.exceptions.RequestException as e:
            print(f"An error occurred: {e}")
        
    return Response({'status': 200})

@api_view(['GET'])
def GetPenny(request):
    stockData =[]
    procesQry = """
                SELECT
                    sn.id,
                    sn.stock_name,
                FROM
                    stock_names sn
                    LEFT JOIN stock_ratios sr ON sr.stock = sn.id
                    LEFT JOIN stock_holdings sh ON sh.stock = sn.id
                WHERE
                    sr.w52High <= 100
                    AND sh.date =(
                        SELECT
                            MAX(date)
                        FROM
                            stock_holdings
                        WHERE
                            stock = sh.stock)
                    AND sh.pmPctT > 50
                    AND m3AvgVol >10000;
                """
    with connection.cursor() as cursor:
        cursor.execute(procesQry)
        rows = cursor.fetchall()

        for data in rows:
            stock_data = {
                        'id': data[0],
                        'stockName': data[1],
                    }
            stockData.append(stock_data)
            
    return Response({'status': 200, 'data':stockData}, 200)