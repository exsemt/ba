require 'test_helper'

class GenericTable::DimensionsControllerTest < ActionController::TestCase
  setup do
    @generic_table_dimension = generic_table_dimensions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generic_table_dimensions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create generic_table_dimension" do
    assert_difference('GenericTable::Dimension.count') do
      post :create, generic_table_dimension: { name: @generic_table_dimension.name }
    end

    assert_redirected_to generic_table_dimension_path(assigns(:generic_table_dimension))
  end

  test "should show generic_table_dimension" do
    get :show, id: @generic_table_dimension
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generic_table_dimension
    assert_response :success
  end

  test "should update generic_table_dimension" do
    put :update, id: @generic_table_dimension, generic_table_dimension: { name: @generic_table_dimension.name }
    assert_redirected_to generic_table_dimension_path(assigns(:generic_table_dimension))
  end

  test "should destroy generic_table_dimension" do
    assert_difference('GenericTable::Dimension.count', -1) do
      delete :destroy, id: @generic_table_dimension
    end

    assert_redirected_to generic_table_dimensions_path
  end
end
