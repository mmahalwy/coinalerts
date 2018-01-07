class Sync
  def initialize(send_notifications: false)
    @binance_client = Binance::Client::REST.new
    @send_notifications = send_notifications
  end

  def perform
    sync_binance
  end

  def sync_coins
    coins_data = CoinsData.new

    coin_market_cap_coins_symbol_map = coins_data.coin_market_cap_coins_symbol_map
    cryptocompare_coins_symbol_map = coins_data.cryptocompare_coins_symbol_map

    coin_market_cap_coins_symbol_map.each do |symbol, data|
      Coin.where(symbol: symbol).first_or_initialize.tap do |coin|
        coin.update_attributes(
          name: data.try(:[], 'name'),
          price_usd: data.try(:[], 'price_usd'),
          rank: coin_market_cap_coin.try(:[], 'rank'),
          market_cap_usd: data.try(:[], 'market_cap_usd'),
          percent_change_1h: data.try(:[], 'percent_change_1h'),
          percent_change_24h: data.try(:[], 'percent_change_24h'),
          percent_change_7d: data.try(:[], 'percent_change_7d'),
        )
      end
    end
  end

  def sync_binance
    # binance = Exchange.find_by_name('binance')
    # data = @binance_client.products['data']
    # assets = assets_keyed_by_symbol(data)
    # created_coins = binance.coins.where(symbol: assets.keys)

    # determine_non_existing_coins(binance, created_coins, assets)

    # create_coin_prices(binance, assets)
  end

  def determine_non_existing_coins(exchange, created_coins, assets)
    created_coins_symbols = created_coins.pluck(:symbol)
    symbols_diff = assets.keys - created_coins_symbols

    if !symbols_diff.blank?
      coins = symbols_diff.map do |symbol|
        exchange.coins.new(
          symbol: symbol,
          asset_symbol: assets[symbol]['baseAsset'],
          asset_name: assets[symbol]['baseAssetName'],
          quote_asset_symbol: assets[symbol]['quoteAsset'],
          quote_asset_name: assets[symbol]['quoteAssetName']
        )
      end

      exchange.coins.import(coins, validate: true)

      if @send_notifications
        TwilioClient.api.account.messages.create(
          from: TWILIO_FROM_PHONE_NUMBER,
          to: TWILIO_TO_PHONE_NUMBER,
          body: "Added to Binance: #{symbols_diff.join(',')}".truncate(1500)
        )
      end
    end
  end

  def assets_keyed_by_symbol(data)
    keyed_assets = {}

    data.each { |asset| keyed_assets[asset['symbol']] = asset }

    keyed_assets
  end

  def create_coin_prices(exchange, assets)
    exchange_id = exchange.id

    coin_prices = exchange.coins.map do |coin|
      CoinPrice.new(
        price: assets[coin.symbol]['close'].to_f,
        exchange_id: exchange_id,
        coin_id: coin.id
      )
    end

    CoinPrice.import(coin_prices, validate: true)
  end
end