require 'test_helper'

class BlocklyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blockly_index_url
    assert_response :success
  end

end
