class ExchangeCoinsController < ApplicationController
  def index
    @exchange_coins = ExchangeCoin.includes(:exchange, :coin).limit(50).order(created_at: :desc)
  end
end
