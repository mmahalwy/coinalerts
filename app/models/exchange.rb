# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Exchange < ApplicationRecord
  has_many :coins
end
