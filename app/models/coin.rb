class Coin < ApplicationRecord
  belongs_to :exchange
  has_many :coin_prices
end
