# == Schema Information
#
# Table name: coins
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  symbol             :string           not null
#  rank               :integer
#  preferred          :boolean          default("false"), not null
#  price_usd          :float
#  market_cap_usd     :float
#  percent_change_1h  :float
#  percent_change_24h :float
#  percent_change_7d  :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  coinmarketcap_id   :string
#
# Indexes
#
#  index_coins_on_market_cap_usd  (market_cap_usd)
#  index_coins_on_name            (name)
#  index_coins_on_preferred       (preferred)
#  index_coins_on_price_usd       (price_usd)
#  index_coins_on_rank            (rank)
#  index_coins_on_symbol          (symbol)
#

class Coin < ApplicationRecord
  has_many :coin_histories
  has_many :exchange_coins
  has_many :exchanges, through: :exchange_coins

  scope :preferred, -> { where(preferred: true) }

  audited
end
