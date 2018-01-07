class CoinmarketcapController < ApplicationController
  def index
    @coins = Coin.preferred
    @exchanges = Exchange.preferred
    @coin_exchanges = ExchangeCoin.where(exchange: @exchanges).group_by(&:coin_id)
  end

  def show
    @coins = Coin.preferred.where('market_cap_usd < ?', params[:amount].to_f)
    @exchanges = Exchange.preferred
    @coin_exchanges = ExchangeCoin.where(exchange: @exchanges).group_by(&:coin_id)
  end
end
