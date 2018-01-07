class CoinmarketcapController < ApplicationController
  def index
    @coins = Coin.preferred
  end
end
