require 'test_helper'

class SumobotsControllerTest < ActionController::TestCase
  setup do
    @sumobot = sumobots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sumobots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sumobot" do
    assert_difference('Sumobot.count') do
      post :create, :sumobot => @sumobot.attributes
    end

    assert_redirected_to sumobot_path(assigns(:sumobot))
  end

  test "should show sumobot" do
    get :show, :id => @sumobot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sumobot.to_param
    assert_response :success
  end

  test "should update sumobot" do
    put :update, :id => @sumobot.to_param, :sumobot => @sumobot.attributes
    assert_redirected_to sumobot_path(assigns(:sumobot))
  end

  test "should destroy sumobot" do
    assert_difference('Sumobot.count', -1) do
      delete :destroy, :id => @sumobot.to_param
    end

    assert_redirected_to sumobots_path
  end
end
