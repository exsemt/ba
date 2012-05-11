require 'test_helper'

class Star::DatesControllerTest < ActionController::TestCase
  setup do
    @star_date = star_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:star_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create star_date" do
    assert_difference('Star::Date.count') do
      post :create, star_date: { day: @star_date.day, month: @star_date.month, quarter: @star_date.quarter, year: @star_date.year }
    end

    assert_redirected_to star_date_path(assigns(:star_date))
  end

  test "should show star_date" do
    get :show, id: @star_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @star_date
    assert_response :success
  end

  test "should update star_date" do
    put :update, id: @star_date, star_date: { day: @star_date.day, month: @star_date.month, quarter: @star_date.quarter, year: @star_date.year }
    assert_redirected_to star_date_path(assigns(:star_date))
  end

  test "should destroy star_date" do
    assert_difference('Star::Date.count', -1) do
      delete :destroy, id: @star_date
    end

    assert_redirected_to star_dates_path
  end
end
