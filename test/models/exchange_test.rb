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

require 'test_helper'

class ExchangeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
