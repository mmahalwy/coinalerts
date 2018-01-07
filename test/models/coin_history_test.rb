# == Schema Information
#
# Table name: coin_histories
#
#  id                 :integer          not null, primary key
#  coin_id            :integer
#  rank               :integer
#  price_usd          :float
#  market_cap_usd     :float
#  percent_change_1h  :float
#  percent_change_24h :float
#  percent_change_7d  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_coin_histories_on_coin_id             (coin_id)
#  index_coin_histories_on_market_cap_usd      (market_cap_usd)
#  index_coin_histories_on_percent_change_1h   (percent_change_1h)
#  index_coin_histories_on_percent_change_24h  (percent_change_24h)
#  index_coin_histories_on_percent_change_7d   (percent_change_7d)
#  index_coin_histories_on_price_usd           (price_usd)
#  index_coin_histories_on_rank                (rank)
#

require 'test_helper'

class CoinHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
