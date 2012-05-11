require 'test_helper'

class Star::CustomersControllerTest < ActionController::TestCase
  setup do
    @star_customer = star_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:star_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create star_customer" do
    assert_difference('Star::Customer.count') do
      post :create, star_customer: { city: @star_customer.city, country: @star_customer.country, customer_no: @star_customer.customer_no, name: @star_customer.name, postcode: @star_customer.postcode, street_number: @star_customer.street_number, type: @star_customer.type }
    end

    assert_redirected_to star_customer_path(assigns(:star_customer))
  end

  test "should show star_customer" do
    get :show, id: @star_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @star_customer
    assert_response :success
  end

  test "should update star_customer" do
    put :update, id: @star_customer, star_customer: { city: @star_customer.city, country: @star_customer.country, customer_no: @star_customer.customer_no, name: @star_customer.name, postcode: @star_customer.postcode, street_number: @star_customer.street_number, type: @star_customer.type }
    assert_redirected_to star_customer_path(assigns(:star_customer))
  end

  test "should destroy star_customer" do
    assert_difference('Star::Customer.count', -1) do
      delete :destroy, id: @star_customer
    end

    assert_redirected_to star_customers_path
  end
end
