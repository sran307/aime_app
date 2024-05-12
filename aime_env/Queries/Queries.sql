-- Ultra filter scan without sma and ema
    SELECT *
FROM trade_data
WHERE `date` = '2024-05-10'
AND `stock` = 453
AND `close` > (
    SELECT `close`
    FROM trade_data 
    WHERE `date` = '2024-05-02'
    AND `stock` = 453
)
AND `close` > (
    SELECT `close`
    FROM trade_data 
    WHERE `date` = '2024-05-09'
    AND `stock` = 453
)
AND `close` > (
    SELECT (`close` * 1.01)
    FROM trade_data 
    WHERE `date` = '2024-05-09'
    AND `stock` = 453
)
AND `close` > 100
AND `close` <= 200
AND volume > 1000000;


