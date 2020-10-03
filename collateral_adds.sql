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
SELECT evt_block_number AS block_number,
       evt_block_time AS block_time,
       c."underlying_token_address" AS asset_address,
       CASE
           WHEN t.symbol = 'WETH' THEN 'ETH'
           ELSE t.symbol
       END AS token_symbol,
       t.decimals AS token_decimals,
       "mintAmount"/10^t.decimals AS asset_amount,
       "mintAmount"/10^t.decimals*p.price AS asset_amount_usd,
       minter AS "user",
       'Compound' AS "project",
       '2' AS "version",
       evt_tx_hash AS tx_hash
FROM
  (SELECT *
   FROM compound_v2."cErc20_evt_Mint"
   UNION SELECT *
   FROM compound_v2."cEther_evt_Mint"
   UNION SELECT *
   FROM compound_v2."CErc20Delegator_evt_Mint") EVENTS
LEFT JOIN compound.view_ctokens c ON events.contract_address = c.contract_address
LEFT JOIN erc20.tokens t ON c.underlying_token_address = t.contract_address
LEFT JOIN prices.usd p ON p.minute = date_trunc('minute', evt_block_time)
AND p.contract_address = c.underlying_token_address



-- MakerDAO