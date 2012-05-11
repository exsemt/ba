require 'test_helper'

class Star::BranchesControllerTest < ActionController::TestCase
  setup do
    @star_branch = star_branches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:star_branches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create star_branch" do
    assert_difference('Star::Branch.count') do
      post :create, star_branch: { branch_no: @star_branch.branch_no, city: @star_branch.city, postcode: @star_branch.postcode, state: @star_branch.state, street_number: @star_branch.street_number }
    end

    assert_redirected_to star_branch_path(assigns(:star_branch))
  end

  test "should show star_branch" do
    get :show, id: @star_branch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @star_branch
    assert_response :success
  end

  test "should update star_branch" do
    put :update, id: @star_branch, star_branch: { branch_no: @star_branch.branch_no, city: @star_branch.city, postcode: @star_branch.postcode, state: @star_branch.state, street_number: @star_branch.street_number }
    assert_redirected_to star_branch_path(assigns(:star_branch))
  end

  test "should destroy star_branch" do
    assert_difference('Star::Branch.count', -1) do
      delete :destroy, id: @star_branch
    end

    assert_redirected_to star_branches_path
  end
end
