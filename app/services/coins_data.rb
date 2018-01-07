class CoinsData
  attr_accessor :coin_market_cap_coins, :cryptocompare_coins_symbol_map

  COINMARKETCAP_LIMIT = 400

  def initialize
    @coin_market_cap_coins = get_coin_market_cap_coins
    @cryptocompare_coins_symbol_map = get_cryptocompare_coins_map
  end

  def get_coin_market_cap_coins
    JSON.parse(Coinmarketcap.coins(COINMARKETCAP_LIMIT).body)
  end

  def get_cryptocompare_coins_map
    Cryptocompare::CoinList.all.try(:[], 'Data')
  end

  def get_coin_info(symbol, base = 'BTC')
    Cryptocompare::CoinSnapshot.find(symbol, base).try(:[], 'Data')
  end

  def get_coin_exchanges(symbol, base = 'BTC')
    get_coin_info(symbol).try(:[], 'Exchanges')
  end

  def coin_market_cap_coins_symbol_map
    symbol_map = {}

    @coin_market_cap_coins.each do |coin|
      symbol_map[coin['symbol']] = coin
    end

    symbol_map
  end
end