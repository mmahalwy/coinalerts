require 'test_helper'

class ExchangeCoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exchange_coins_index_url
    assert_response :success
  end

end
