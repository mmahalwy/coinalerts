class ExchangeCoinsController < ApplicationController
  def index
    @exchange_coins = ExchangeCoin.includes(:exchange, :coin).limit(params[:limit]).order(created_at: :desc)
  end

  def show
    @coin = Coin.find_by_symbol(params[:symbol])
    @exchanges = @coin.exchanges
  end
end
