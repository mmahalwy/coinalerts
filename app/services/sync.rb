class Sync
  def initialize
    @binance_client = Binance::Client::REST.new
  end

  def perform
    setup_binance
  end

  def setup_binance
    binance = Exchange.find_or_create_by!(name: 'binance')
    data = @binance_client.products['data']
    assets = assets_keyed_by_symbol(data)
    created_coins = binance.coins.where(symbol: assets.keys)

    determine_non_existing_coins(created_coins, assets.keys)
    create_coin_price(binance, created_coins, assets)
  end

  def determine_non_existing_coins(coins, symbols)
    coin_symbols = coins.pluck(:symbol)
    symbols_diff = symbols - coin_symbols

    if !symbols_diff.blank?
      # Do something
    end
  end

  def assets_keyed_by_symbol(data)
    keyed_assets = {}

    data.each { |asset| keyed_assets[asset['symbol']] = asset }

    keyed_assets
  end

  def create_coin_price(exchange, coins, assets)
    coins.each do |coin|
      coin.coin_prices.create!(
        price: assets[coin.symbol]['close'].to_f,
        exchange: exchange
      )
    end
  end
end