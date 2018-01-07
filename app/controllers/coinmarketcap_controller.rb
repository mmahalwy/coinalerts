class CoinmarketcapController < ApplicationController
  def index
    @coins = Coin.preferred
    @exchanges = Exchange.preferred
    @coin_exchanges = ExchangeCoin.where(exchange: @exchanges).group_by(&:coin_id)
  end
end
