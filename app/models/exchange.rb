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

class Exchange < ApplicationRecord
  has_many :coins
end
