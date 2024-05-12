# # Define the target date and stock ID
        # target_date = '2024-05-10'
        # date_1 = '2024-05-02'
        # date_2 = '2024-05-09'
        
        stocks = StockNames.objects.all()
        for stock in stocks:
            stock_id = stock.id

        #     # Subqueries to get the close values
        #     close_subquery_1 = TradeData.objects.filter(
        #         date=date_1,
        #         stock=stock_id
        #     ).values('close')[:1]

        #     close_subquery_2 = TradeData.objects.filter(
        #         date=date_2,
        #         stock=stock_id
        #     ).values('close')[:1]

        #     close_subquery_3 = TradeData.objects.filter(
        #         date=date_2,
        #         stock=stock_id
        #     ).annotate(close_times_101=F('close') * 1.01).values('close_times_101')[:1]
        #     # Main query to retrieve trade data
        #     trade_data = TradeData.objects.filter(
        #         date=target_date,
        #         stock=stock_id,
        #         # close__gt=Subquery(close_subquery_1),
        #         # close__gt=Subquery(close_subquery_2),
        #         # close__gt=Subquery(close_subquery_3),
        #         # close__gt=100,
        #         close__gt=Subquery(close_subquery_1).bitand(Subquery(close_subquery_2)).bitand(Subquery(close_subquery_3)).bitand(100),
        #         close__lte=200,
        #         volume__gt=1000000
        #     )
        #     if trade_data.exists():
        #         print(trade_data.values())
        
        
        12 sunday
        end_date 10 friday
                 09 thurs
                 08 wed
                 07 tue
                 06 mon
                 05 sun
                 04 sat
                 03 fri
                 02 thu
                 start date 