require 'test_helper'

class BlockliesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blocklies_url
    assert_response :success
  end

end
