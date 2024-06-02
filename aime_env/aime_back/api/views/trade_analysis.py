from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import JsonResponse
from ..models import StockNames, TradeData, Holidays, SwingData, StockCodes, StockRatios, StockHoldings, StockForecast, StockCommentary,SwingStocks,TrendySector
from django.db.models import Max
from django.db.models import Q
from django.db import connection


@api_view(['GET'])
def getTrendySector(request):
    # stocks = StockNames.objects.filter(Q(isActive=True) | Q(isFno=True)).values()
    # for stock in stocks:
    #     id = stock['id']
    dataExist = TrendySector.objects.exists()
    if dataExist:
        tableName = 'trendy_sector'
        with connection.cursor() as cursor:
            cursor.execute("TRUNCATE TABLE {};".format(tableName))
    ratios = StockRatios.objects.filter(Q(weekChange__gt=10) | Q(monthChange__gt=20)).values()
    for ratio in ratios:
        stock=ratio['stock_id']
        sectorData = StockNames.objects.filter(id=stock).values('sector')
        try:
            TrendySector.objects.get(sector=sectorData[0]['sector'])
            trendys = TrendySector.objects.filter(sector=sectorData[0]['sector']).values()
            for trendy in trendys:
                number=trendy['no']+1
                weekChange=trendy['week']+ratio['weekChange']
                monthChange=trendy['month']+ratio['monthChange']
                TrendySector.objects.filter(sector=sectorData[0]['sector']).update(
                    no=number,
                    week=weekChange,
                    month=monthChange,
                    perc=((weekChange+monthChange)/number*2)
                )
                print('updated')
        except TrendySector.DoesNotExist:
            TrendySector.objects.create(
                sector=sectorData[0]['sector'],
                no=1,
                week=ratio['weekChange'],
                month=ratio['monthChange'],
                perc=((ratio['weekChange']+ratio['monthChange'])/2)
            )
            print('data inserted')

    TrendySector.objects.filter(perc__lt=20).delete()

    return Response({'status': 200})

@api_view(['GET'])
def swingAnalysis(request):
    
    max_date = SwingStocks.objects.aggregate(Max('date'))['date__max']
    stocks = SwingStocks.objects.filter(date=max_date).values()
    for stock in stocks:
        rank = 1
        comments = StockCommentary.objects.filter(stock=stock['stock_id']).values()
        for comment in comments:
            if comment['mood']=='Positive':
                rank = rank+10
            elif comment['mood'] =='Negative':
                rank=rank-10
            else:
                rank=rank+0
        SwingStocks.objects.filter(stock=stock['stock_id']).update(
            com_rank=rank
        )
        
        ratios = StockRatios.objects.filter(stock=stock['stock_id']).values()
        for ratio in ratios:
            if ratio['divYield']:
                ratio_rank = 1+ratio['divYield']
                rank=rank*ratio_rank
                SwingStocks.objects.filter(stock=stock['stock_id']).update(
                    div_rank=ratio['divYield']
                )
            else:
                SwingStocks.objects.filter(stock=stock['stock_id']).update(
                    div_rank=0
                )
        
        max_date_for_stock = StockHoldings.objects.filter(stock=stock['stock_id']).aggregate(Max('date'))['date__max']
        holdings = StockHoldings.objects.filter(date=max_date_for_stock, stock=stock['stock_id']).values()
        for holding in holdings:
            holding_rank = holding['uPlPctT']+holding['mfPctT']+holding['isPctT']+holding['fiPctT']
            rank=rank+holding_rank
            SwingStocks.objects.filter(stock=stock['stock_id']).update(
                    hol_rank=holding_rank
                )
        
        SwingStocks.objects.filter(stock=stock['stock_id']).update(
                    tot_rank=rank
                )

    stockData=[]
    swing_stocks = SwingStocks.objects.filter(date=max_date).order_by('-tot_rank').values()
    for swing_stock in swing_stocks:
        stock_instance = StockNames.objects.filter(id=swing_stock['stock_id']).values()
        for stock in stock_instance:
            try:
                TrendySector.objects.get(sector=stock['sector'])
                totalRank = SwingStocks.objects.filter(stock=stock['id']).values('tot_rank')

                SwingStocks.objects.filter(stock=stock['id']).update(
                    tot_rank=totalRank[0]['tot_rank']+50
                )
            except TrendySector.DoesNotExist:
                print('no action')

            stock_data = {
                'id': stock['id'],
                'stockName': stock['stockName'],
                'sector': stock['sector']
            }
        stockData.append(stock_data)

    return Response({'status': 200, 'data':stockData}, 200)



