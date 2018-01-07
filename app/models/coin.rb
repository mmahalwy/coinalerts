# == Schema Information
#
# Table name: coins
#
#  id                 :integer          not null, primary key
#  symbol             :string
#  asset_symbol       :string
#  asset_name         :string
#  quote_asset_symbol :string
#  quote_asset_name   :string
#  exchange_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_coins_on_asset_symbol        (asset_symbol)
#  index_coins_on_exchange_id         (exchange_id)
#  index_coins_on_quote_asset_symbol  (quote_asset_symbol)
#  index_coins_on_symbol              (symbol)
#

class Coin < ApplicationRecord
  belongs_to :exchange
  has_many :coin_prices
end
