module Seeder
  EXCHANGES = [
    { name: 'CCCAGG', preferred: false },
    { name: 'ANXBTC', preferred: false },
    { name: 'Binance', preferred: true },
    { name: 'Bit2C', preferred: false },
    { name: 'BitBay', preferred: false },
    { name: 'BitcoinDE', preferred: false },
    { name: 'Bitfinex', preferred: false },
    { name: 'bitFlyer', preferred: false },
    { name: 'bitFlyerFX', preferred: false },
    { name: 'Bithumb', preferred: false },
    { name: 'BitMarket', preferred: false },
    { name: 'Bitso', preferred: false },
    { name: 'BitSquare', preferred: false },
    { name: 'Bitstamp', preferred: false },
    { name: 'Bittrex', preferred: false },
    { name: 'Bleutrade', preferred: false },
    { name: 'BTC38', preferred: false },
    { name: 'BTCChina', preferred: false },
    { name: 'BTCE', preferred: false },
    { name: 'BTCMarkets', preferred: false },
    { name: 'btcXchange', preferred: false },
    { name: 'BTCXIndia', preferred: false },
    { name: 'BTER', preferred: false },
    { name: 'CCEDK', preferred: false },
    { name: 'CCEX', preferred: false },
    { name: 'Cexio', preferred: false },
    { name: 'CHBTC', preferred: false },
    { name: 'Coinbase', preferred: true },
    { name: 'CoinCheck', preferred: false },
    { name: 'CoinExchange', preferred: false },
    { name: 'Coinfloor', preferred: false },
    { name: 'Coinone', preferred: false },
    { name: 'Coinroom', preferred: false },
    { name: 'Coinse', preferred: false },
    { name: 'Coinsetter', preferred: false },
    { name: 'Cryptopia', preferred: false },
    { name: 'CryptoX', preferred: false },
    { name: 'Cryptsy', preferred: false },
    { name: 'EtherDelta', preferred: true },
    { name: 'EthexIndia', preferred: false },
    { name: 'Exmo', preferred: false },
    { name: 'Gatecoin', preferred: false },
    { name: 'Gemini', preferred: false },
    { name: 'HitBTC', preferred: false },
    { name: 'Huobi', preferred: false },
    { name: 'itBit', preferred: false },
    { name: 'Jubi', preferred: false },
    { name: 'Korbit', preferred: false },
    { name: 'Kraken', preferred: true },
    { name: 'Kucoin', preferred: true },
    { name: 'LakeBTC', preferred: false },
    { name: 'Liqui', preferred: false },
    { name: 'LiveCoin', preferred: false },
    { name: 'LocalBitcoins', preferred: false },
    { name: 'Luno', preferred: false },
    { name: 'Lykke', preferred: false },
    { name: 'MercadoBitcoin', preferred: false },
    { name: 'MonetaGo', preferred: false },
    { name: 'MtGox', preferred: false },
    { name: 'Novaexchange', preferred: false },
    { name: 'OKCoin', preferred: false },
    { name: 'Paymium', preferred: false },
    { name: 'Poloniex', preferred: true },
    { name: 'QuadrigaCX', preferred: false },
    { name: 'Quoine', preferred: false },
    { name: 'Remitano', preferred: false },
    { name: 'TheRockTrading', preferred: false },
    { name: 'Tidex', preferred: false },
    { name: 'TuxExchange', preferred: false },
    { name: 'Unocoin', preferred: false },
    { name: 'Vaultoro', preferred: false },
    { name: 'ViaBTC', preferred: false },
    { name: 'WavesDEX', preferred: false },
    { name: 'Yacuna', preferred: false },
    { name: 'Yobit', preferred: false },
    { name: 'Yunbi', preferred: false },
    { name: 'Zaif', preferred: false },
  ]

  def self.seed
    seed_exchanges

    coins_data = CoinsData.new

    get_coinmarketcap_coins_symbol_map = coins_data.get_coinmarketcap_coins_symbol_map
    cryptocompare_coins_symbol_map = coins_data.cryptocompare_coins_symbol_map

    coins_to_create = cryptocompare_coins_symbol_map.map do |symbol, coin|
      coin_market_cap_coin = get_coinmarketcap_coins_symbol_map[symbol]

      {
        name: coin['Name'],
        symbol: symbol,
        preferred: coin_market_cap_coin.present?,
        price_usd: coin_market_cap_coin.try(:[], 'price_usd'),
        rank: coin_market_cap_coin.try(:[], 'rank'),
        market_cap_usd: coin_market_cap_coin.try(:[], 'market_cap_usd'),
        percent_change_1h: coin_market_cap_coin.try(:[], 'percent_change_1h'),
        percent_change_24h: coin_market_cap_coin.try(:[], 'percent_change_24h'),
        percent_change_7d: coin_market_cap_coin.try(:[], 'percent_change_7d'),
      }
    end

    Coin.import(coins_to_create, validate: true)
  end

  def self.seed_exchanges
    Exchange.import(EXCHANGES, validate: true)
  end
end