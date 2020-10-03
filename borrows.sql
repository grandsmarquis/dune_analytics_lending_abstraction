

-- AAVE 1

SELECT evt_block_number AS "block_number",
    evt_block_time AS "block_time",
    _reserve AS "asset_address",
    token.symbol AS "asset_symbol",
    token.decimals AS "asset_decimals",
    _amount AS "asset_amount",
    "_amount"/10^token.decimals*p.price AS usd_amount,
    "_user" as borrower,
    'Aave' AS "project",
    '1' AS "version",
    evt_tx_hash AS "tx_hash",
    "evt_index"
FROM aave."LendingPool_evt_Borrow"
    INNER JOIN erc20."tokens" token ON "_reserve" = token."contract_address"
    LEFT JOIN prices."usd" p ON p."minute" = date_trunc('minute', "evt_block_time")
        AND p."contract_address" = "_reserve"

-- COMPOUND 1

SELECT evt_block_number AS block_number,
    evt_block_time AS block_time,
    c."underlying_token_address" AS asset_address,
    CASE
           WHEN t.symbol = 'WETH' THEN 'ETH'
           ELSE t.symbol
       END AS asset_symbol,
    t.decimals AS asset_decimals,
    "borrowAmount"/10^t.decimals AS asset_amount,
    "borrowAmount"/10^t.decimals*p.price AS usd_amount,
    borrower,
    'Compound' AS "project",
    '2' AS "version",
    evt_tx_hash AS tx_hash
FROM
    (                        SELECT *
        FROM compound_v2."cErc20_evt_Borrow"
    UNION
        SELECT *
        FROM compound_v2."cEther_evt_Borrow"
    UNION
        SELECT *
        FROM compound_v2."CErc20Delegator_evt_Borrow") EVENTS
    LEFT JOIN compound.view_ctokens c ON events.contract_address = c.contract_address
    LEFT JOIN erc20.tokens t ON c.underlying_token_address = t.contract_address
    LEFT JOIN prices.usd p ON p.minute = date_trunc('minute', evt_block_time)
        AND p.contract_address = c.underlying_token_address

        --MAKERDAO
        --Note: might derive the evt index with thransaction index or call

        SELECT call_block_number AS "block_number",
    call_block_time AS "block_time",
    '\x6b175474e89094c44da98b954eedeac495271d0f'::bytea AS "asset_address",
    'DAI' AS "asset_symbol",
    18 AS "asset_decimals",
    wad AS "asset_amount",
    "wad"/10^18*p.price AS usd_amount,
    "usr" as borrower,
    'MakerDAO' AS "project",
    '2' AS "version",
    call_tx_hash AS "tx_hash",
    1 as "evt_index"
FROM makermcd."DAI_call_mint" 
    LEFT JOIN prices."usd" p ON p."minute" = date_trunc('minute', call_block_time)
        AND p."contract_address" = '\x6b175474e89094c44da98b954eedeac495271d0f'
WHERE call_success = 'true' AND wad > 0