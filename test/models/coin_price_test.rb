# == Schema Information
#
# Table name: coin_prices
#
#  id          :integer          not null, primary key
#  price       :float            not null
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

require 'test_helper'

class CoinPriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
