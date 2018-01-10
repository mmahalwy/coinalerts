class ExchangeCoinsController < ApplicationController
  def index
    @exchange_coins = ExchangeCoin.includes(:exchange, :coin).limit(params[:limit]).order(created_at: :desc)
  end
end
