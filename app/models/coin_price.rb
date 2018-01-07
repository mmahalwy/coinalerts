# == Schema Information
#
# Table name: coin_prices
#
#  id          :integer          not null, primary key
#  price       :float
#  coin_id     :integer
#  exchange_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_coin_prices_on_coin_id      (coin_id)
#  index_coin_prices_on_exchange_id  (exchange_id)
#  index_coin_prices_on_price        (price)
#

class CoinPrice < ApplicationRecord
  belongs_to :coin
  belongs_to :exchange
end
