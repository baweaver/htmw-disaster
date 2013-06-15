require 'test_helper'

class FlareControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get call" do
    get :call
    assert_response :success
  end

  test "should get cancel" do
    get :cancel
    assert_response :success
  end

  test "should get respond" do
    get :respond
    assert_response :success
  end

end
