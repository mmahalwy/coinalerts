# == Schema Information
#
# Table name: exchange_coins
#
#  id                 :integer          not null, primary key
#  exchange_id        :integer
#  coin_id            :integer
#  symbol             :string           not null
#  asset_symbol       :string           not null
#  asset_name         :string           not null
#  quote_asset_symbol :string           not null
#  quote_asset_name   :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_exchange_coins_on_asset_symbol        (asset_symbol)
#  index_exchange_coins_on_coin_id             (coin_id)
#  index_exchange_coins_on_exchange_id         (exchange_id)
#  index_exchange_coins_on_quote_asset_symbol  (quote_asset_symbol)
#  index_exchange_coins_on_symbol              (symbol)
#

require 'test_helper'

class ExchangeCoinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
