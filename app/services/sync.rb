class Sync
  def initialize(send_notifications: false)
    @send_notifications = send_notifications
    @notifications = Notifications.new(send_notifications: send_notifications)
  end

  def perform
    sync_coins
  end

  def sync_binance
    client = Binance::Client::REST.new
    products = client.products['data']

    products.each do |product|
      begin
        data = CoinsData.coinmarketcap_data(product['baseAssetName'].gsub(/ /, "-"))

        Coin.where(symbol: product['baseAsset']).first_or_initialize.tap do |coin|
          coin.name = product.try(:[], 'baseAssetName')
          coin.price_usd = data.try(:[], 'price_usd')
          coin.rank = data.try(:[], 'rank')
          coin.market_cap_usd = data.try(:[], 'market_cap_usd')
          coin.percent_change_1h = data.try(:[], 'percent_change_1h')
          coin.percent_change_24h = data.try(:[], 'percent_change_24h')
          coin.percent_change_7d = data.try(:[], 'percent_change_7d')
          coin.preferred = true
          coin.save!


          check_exchanges(coin)
        end
      rescue
      end
    end
  end

  def sync_kucoin
    products = KucoinRuby::Market.coins['data']

    products.each do |product|
      data = CoinsData.coinmarketcap_data(product['name'].gsub(/ /, "-"))

      Coin.where(symbol: product['coin']).first_or_initialize.tap do |coin|
        coin.name = product.try(:[], 'coin')
        coin.price_usd = data.try(:[], 'price_usd')
        coin.rank = data.try(:[], 'rank')
        coin.market_cap_usd = data.try(:[], 'market_cap_usd')
        coin.percent_change_1h = data.try(:[], 'percent_change_1h')
        coin.percent_change_24h = data.try(:[], 'percent_change_24h')
        coin.percent_change_7d = data.try(:[], 'percent_change_7d')
        coin.preferred = true
        coin.save!

        check_exchanges(coin)
      end
    end
  end

  def sync_coins
    coins_data = CoinsData.new

    get_coinmarketcap_coins_symbol_map = coins_data.get_coinmarketcap_coins_symbol_map

    Coin.preferred.each do |coin|
      sync_coin(coin, get_coinmarketcap_coins_symbol_map)
    end
  end

  def sync_coin(coin, get_coinmarketcap_coins_symbol_map)
    coinmarketcap_id = coin.coinmarketcap_id || coin.name.gsub(/ /, "-")
    data = get_coinmarketcap_coins_symbol_map[coin.symbol] || CoinsData.coinmarketcap_data(coinmarketcap_id)
  rescue
      Rails.logger.info "Rescued an error with fetching data for #{coin.symbol}"
  ensure
      coin.name = data.try(:[], 'name') || 'N/A'
      coin.coinmarketcap_id = data.try(:[], 'id')
      coin.price_usd = data.try(:[], 'price_usd')
      coin.rank = data.try(:[], 'rank')
      coin.market_cap_usd = data.try(:[], 'market_cap_usd')
      coin.percent_change_1h = data.try(:[], 'percent_change_1h')
      coin.percent_change_24h = data.try(:[], 'percent_change_24h')
      coin.percent_change_7d = data.try(:[], 'percent_change_7d')
      coin.save!

      check_exchanges(coin)
  end

  def check_exchanges(coin)
    exchanges_data = CoinsData.coin_exchanges(coin.symbol)

    if exchanges_data.nil?
      Rails.logger.info "No exchanges found for #{coin.symbol}"
      return
    end

    exchanges_data.each do |exchange_data|
      exchange = Exchange.find_or_create_by(name: exchange_data['MARKET'])

      ExchangeCoin.find_or_initialize_by(exchange: exchange, coin: coin) do |exchange_coin|
        if exchange_coin.new_record? && exchange.preferred? && @send_notifications
          @notifications.send_twilio_notification("Added to #{exchange.name}: #{coin.name}")
        end

        exchange_coin.save!
      end
    end
  end

  def
    coin.coin_histories.create(
      rank: coin.rank,
      price_usd: coin.price_usd,
      market_cap_usd: coin.market_cap_usd,
      percent_change_1h: coin.percent_change_1h,
      percent_change_24h: coin.percent_change_24h,
      percent_change_7d: coin.percent_change_7d,
    )
  end
end
