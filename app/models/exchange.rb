# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  preferred  :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_exchanges_on_name       (name)
#  index_exchanges_on_preferred  (preferred)
#

class Exchange < ApplicationRecord
  has_many :exchange_coins
  has_many :coins, through: :exchange_coins

  scope :preferred, -> { where(preferred: true) }
end
