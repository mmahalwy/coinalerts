class Sync
  def initialize(send_notifications: false)
    @send_notifications = send_notifications
    @notifications = Notifications.new(send_notifications: send_notifications)
  end

  def perform
    sync_coins
  end

  def sync_coins
    coins_data = CoinsData.new

    coin_market_cap_coins_symbol_map = coins_data.coin_market_cap_coins_symbol_map

    coin_market_cap_coins_symbol_map.each do |symbol, data|
      Coin.where(symbol: symbol).first_or_initialize.tap do |coin|
        coin.name = data.try(:[], 'name')
        coin.price_usd = data.try(:[], 'price_usd')
        coin.rank = data.try(:[], 'rank')
        coin.market_cap_usd = data.try(:[], 'market_cap_usd')
        coin.percent_change_1h = data.try(:[], 'percent_change_1h')
        coin.percent_change_24h = data.try(:[], 'percent_change_24h')
        coin.percent_change_7d = data.try(:[], 'percent_change_7d')
        coin.save!

        create_coin_history(coin)
        check_exchanges(coins_data, coin)
      end
    end
  end

  def check_exchanges(coins_data, coin)
    exchanges_data = coins_data.get_coin_exchanges(coin.symbol)

    if exchanges_data.nil?
      Rails.logger.debug "No exchanges found for #{coin.symbol}"
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

  def create_coin_history(coin)
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