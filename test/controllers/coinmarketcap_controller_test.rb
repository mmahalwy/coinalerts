require 'test_helper'

class CoinmarketcapControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coinmarketcap_index_url
    assert_response :success
  end

end
