-- AAve

SELECT evt_block_number AS "block_number",
    evt_block_time AS "block_time",
    _reserve AS "asset_address",
    token.symbol AS "asset_symbol",
    token.decimals AS "asset_decimals",
    _amount AS "asset_amount",
    "_amount"/10^token.decimals*p.price AS usd_amount,
    "_user" as "user",
    'Aave' AS "project",
    '1' AS "version",
    evt_tx_hash AS "tx_hash",
    "evt_index"
FROM aave."LendingPool_evt_Deposit"
    INNER JOIN erc20."tokens" token ON "_reserve" = token."contract_address"
    LEFT JOIN prices."usd" p ON p."minute" = date_trunc('minute', "evt_block_time")
        AND p."contract_address" = "_reserve" 


        --Compound