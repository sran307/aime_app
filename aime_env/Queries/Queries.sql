-- Ultra filter scan without sma and ema
SELECT
    *
FROM
    trade_data
WHERE
    `date` = '2024-05-10'
    AND `stock` = 453
    AND `close` >(
        SELECT
            `close`
        FROM
            trade_data
        WHERE
            `date` = '2024-05-02'
            AND `stock` = 453)
    AND `close` >(
        SELECT
            `close`
        FROM
            trade_data
        WHERE
            `date` = '2024-05-09'
            AND `stock` = 453)
    AND `close` >(
        SELECT
            (`close` * 1.01)
        FROM
            trade_data
        WHERE
            `date` = '2024-05-09'
            AND `stock` = 453)
    AND `close` > 100
    AND `close` <= 200
    AND volume > 1000000;

--PENNY STOCK FILTERING QUERIES
SELECT
    sn.id,
    sn.stock_name,
    sh.pmPctT
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
    AND sh.pmPctT > 50;

