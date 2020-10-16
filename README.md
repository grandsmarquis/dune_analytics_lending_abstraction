# dune_analytics_lending_abstraction


## Files:
 
 * main.sql (has the tables structure)
 * borrows/repay/add_collateral/remove has the queries for each project per type of event. Then you'll just need to make them in one query like [this](https://github.com/duneanalytics/abstractions/blob/master/schema/dex/trades.sql)
 
 ## projects
 
 * Aave all queries are done for the 4 type of events
 * Compound same
 * MakerDAO (borrow and repay are done) For the add collateral you should look into [this query](https://explore.duneanalytics.com/queries/1005/source#1684) and [the token addresses /tried to make a script with dai.js to get them but ddn't manage easily](https://changelog.makerdao.com/releases/mainnet/1.1.2/contracts.json)
 * Dy/DX None done
 
 
 ## Resources that can help
 
 * https://github.com/duneanalytics/abstractions/blob/master/schema/dex/trades.sql
 * https://explore.duneanalytics.com/dashboard/compound-master-
 * For liquidations: https://explore.duneanalytics.com/dashboard/liquidation-success-rate
 
 
 
