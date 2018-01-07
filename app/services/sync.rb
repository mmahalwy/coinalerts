class Sync
  def initialize(send_notifications: false)
    @binance_client = Binance::Client::REST.new
    @send_notifications = send_notifications
  end

  def perform
    setup_binance
  end

  def setup_binance
    binance = Exchange.includes(:coins).find_or_create_by!(name: 'binance')
    data = @binance_client.products['data']
    assets = assets_keyed_by_symbol(data)
    created_coins = binance.coins.where(symbol: assets.keys)

    determine_non_existing_coins(binance, created_coins, assets)

    create_coin_prices(binance, assets)
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