# == Schema Information
#
# Table name: coins
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  symbol             :string           not null
#  preferred          :boolean          default("false"), not null
#  price_usd          :float
#  market_cap_usd     :float
#  percent_change_1h  :float
#  percent_change_24h :float
#  percent_change_7d  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class CoinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
