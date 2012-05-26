require 'test_helper'

class SqlRequestsControllerTest < ActionController::TestCase
  setup do
    @sql_request = sql_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sql_requests)
  end

  test "should show sql_request" do
    get :show, id: @sql_request
    assert_response :success
  end

  test "should destroy sql_request" do
    assert_difference('SqlRequest.count', -1) do
      delete :destroy, id: @sql_request
    end

    assert_redirected_to sql_requests_path
  end
end
