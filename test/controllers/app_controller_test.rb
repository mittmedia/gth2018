require 'test_helper'

class AppControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get app_show_url
    assert_response :success
  end

end
