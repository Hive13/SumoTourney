require 'test_helper'

class TeamApprovalsControllerTest < ActionController::TestCase
  setup do
    @team_approval = team_approvals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_approvals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_approval" do
    assert_difference('TeamApproval.count') do
      post :create, :team_approval => @team_approval.attributes
    end

    assert_redirected_to team_approval_path(assigns(:team_approval))
  end

  test "should show team_approval" do
    get :show, :id => @team_approval.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team_approval.to_param
    assert_response :success
  end

  test "should update team_approval" do
    put :update, :id => @team_approval.to_param, :team_approval => @team_approval.attributes
    assert_redirected_to team_approval_path(assigns(:team_approval))
  end

  test "should destroy team_approval" do
    assert_difference('TeamApproval.count', -1) do
      delete :destroy, :id => @team_approval.to_param
    end

    assert_redirected_to team_approvals_path
  end
end
