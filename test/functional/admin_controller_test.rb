require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get continders" do
    get :continders
    assert_response :success
  end

end
