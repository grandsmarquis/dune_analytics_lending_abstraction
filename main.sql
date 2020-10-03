--Current supports
-- Aave
-- Compound
-- MakerDAO

CREATE TABLE lending.borrows
(
    "block_number" numeric NOT NULL,
    "block_time" timestamptz NOT NULL,
    "asset_address" bytea,
    "asset_symbol" text,
    "asset_decimals" numeric,
    "asset_amount" numeric,
    "borrower" bytea,
    "project" text NOT NULL,
    "version" text,
    "usd_amount" numeric,
    "tx_hash" bytea NOT NULL,
    "evt_index" integer
);

CREATE TABLE lending.repays
(
    "block_number" numeric NOT NULL,
    "block_time" timestamptz NOT NULL,
    "asset_address" bytea,
    "asset_symbol" text,
    "asset_decimals" numeric,
    "asset_amount" numeric,
    "borrower" bytea,
    "project" text NOT NULL,
    "version" text,
    "usd_amount" numeric,
    "tx_hash" bytea NOT NULL,
    "evt_index" integer
);

CREATE TABLE lending.collateral_adds
(
    "block_number" numeric NOT NULL,
    "block_time" timestamptz NOT NULL,
    "asset_address" bytea,
    "asset_symbol" text,
    "asset_decimals" numeric,
    "asset_amount" numeric,
    "user" bytea,
    "project" text NOT NULL,
    "version" text,
    "usd_amount" numeric,
    "tx_hash" bytea NOT NULL,
    "evt_index" integer
);

CREATE TABLE lending.collateral_redeems
(
    "block_number" numeric NOT NULL,
    "block_time" timestamptz NOT NULL,
    "asset_address" bytea,
    "asset_symbol" text,
    "asset_decimals" numeric,
    "asset_amount" numeric,
    "user" bytea,
    "project" text NOT NULL,
    "version" text,
    "usd_amount" numeric,
    "tx_hash" bytea NOT NULL,
    "evt_index" integer
);