require 'test_helper'

class GenericTable::DimensionValuesControllerTest < ActionController::TestCase
  setup do
    @generic_table_dimension_value = generic_table_dimension_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generic_table_dimension_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create generic_table_dimension_value" do
    assert_difference('GenericTable::DimensionValue.count') do
      post :create, generic_table_dimension_value: { aggregation_id: @generic_table_dimension_value.aggregation_id, parent_id: @generic_table_dimension_value.parent_id, value: @generic_table_dimension_value.value }
    end

    assert_redirected_to generic_table_dimension_value_path(assigns(:generic_table_dimension_value))
  end

  test "should show generic_table_dimension_value" do
    get :show, id: @generic_table_dimension_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generic_table_dimension_value
    assert_response :success
  end

  test "should update generic_table_dimension_value" do
    put :update, id: @generic_table_dimension_value, generic_table_dimension_value: { aggregation_id: @generic_table_dimension_value.aggregation_id, parent_id: @generic_table_dimension_value.parent_id, value: @generic_table_dimension_value.value }
    assert_redirected_to generic_table_dimension_value_path(assigns(:generic_table_dimension_value))
  end

  test "should destroy generic_table_dimension_value" do
    assert_difference('GenericTable::DimensionValue.count', -1) do
      delete :destroy, id: @generic_table_dimension_value
    end

    assert_redirected_to generic_table_dimension_values_path
  end
end
