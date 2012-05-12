require 'test_helper'

class GenericTable::FactValuesControllerTest < ActionController::TestCase
  setup do
    @generic_table_fact_value = generic_table_fact_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generic_table_fact_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create generic_table_fact_value" do
    assert_difference('GenericTable::FactValue.count') do
      post :create, generic_table_fact_value: { dimension_value_id: @generic_table_fact_value.dimension_value_id, group: @generic_table_fact_value.group, value: @generic_table_fact_value.value }
    end

    assert_redirected_to generic_table_fact_value_path(assigns(:generic_table_fact_value))
  end

  test "should show generic_table_fact_value" do
    get :show, id: @generic_table_fact_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generic_table_fact_value
    assert_response :success
  end

  test "should update generic_table_fact_value" do
    put :update, id: @generic_table_fact_value, generic_table_fact_value: { dimension_value_id: @generic_table_fact_value.dimension_value_id, group: @generic_table_fact_value.group, value: @generic_table_fact_value.value }
    assert_redirected_to generic_table_fact_value_path(assigns(:generic_table_fact_value))
  end

  test "should destroy generic_table_fact_value" do
    assert_difference('GenericTable::FactValue.count', -1) do
      delete :destroy, id: @generic_table_fact_value
    end

    assert_redirected_to generic_table_fact_values_path
  end
end
