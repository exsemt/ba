require 'test_helper'

class GenericTable::AggregationsControllerTest < ActionController::TestCase
  setup do
    @generic_table_aggregation = generic_table_aggregations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generic_table_aggregations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create generic_table_aggregation" do
    assert_difference('GenericTable::Aggregation.count') do
      post :create, generic_table_aggregation: { dimension_id: @generic_table_aggregation.dimension_id, name: @generic_table_aggregation.name, parent_id: @generic_table_aggregation.parent_id }
    end

    assert_redirected_to generic_table_aggregation_path(assigns(:generic_table_aggregation))
  end

  test "should show generic_table_aggregation" do
    get :show, id: @generic_table_aggregation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generic_table_aggregation
    assert_response :success
  end

  test "should update generic_table_aggregation" do
    put :update, id: @generic_table_aggregation, generic_table_aggregation: { dimension_id: @generic_table_aggregation.dimension_id, name: @generic_table_aggregation.name, parent_id: @generic_table_aggregation.parent_id }
    assert_redirected_to generic_table_aggregation_path(assigns(:generic_table_aggregation))
  end

  test "should destroy generic_table_aggregation" do
    assert_difference('GenericTable::Aggregation.count', -1) do
      delete :destroy, id: @generic_table_aggregation
    end

    assert_redirected_to generic_table_aggregations_path
  end
end
