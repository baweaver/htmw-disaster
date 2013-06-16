require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get read" do
    get :read
    assert_response :success
  end

end
