# == Schema Information
#
# Table name: exchange_coins
#
#  id          :integer          not null, primary key
#  exchange_id :integer
#  coin_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_exchange_coins_on_coin_id      (coin_id)
#  index_exchange_coins_on_exchange_id  (exchange_id)
#

require 'test_helper'

class ExchangeCoinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
