require 'test_helper'

class Star::FactsControllerTest < ActionController::TestCase
  setup do
    @star_fact = star_facts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:star_facts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create star_fact" do
    assert_difference('Star::Fact.count') do
      post :create, star_fact: { branch_id: @star_fact.branch_id, commission: @star_fact.commission, customer_id: @star_fact.customer_id, date_id: @star_fact.date_id, discount: @star_fact.discount, number: @star_fact.number, product_id: @star_fact.product_id }
    end

    assert_redirected_to star_fact_path(assigns(:star_fact))
  end

  test "should show star_fact" do
    get :show, id: @star_fact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @star_fact
    assert_response :success
  end

  test "should update star_fact" do
    put :update, id: @star_fact, star_fact: { branch_id: @star_fact.branch_id, commission: @star_fact.commission, customer_id: @star_fact.customer_id, date_id: @star_fact.date_id, discount: @star_fact.discount, number: @star_fact.number, product_id: @star_fact.product_id }
    assert_redirected_to star_fact_path(assigns(:star_fact))
  end

  test "should destroy star_fact" do
    assert_difference('Star::Fact.count', -1) do
      delete :destroy, id: @star_fact
    end

    assert_redirected_to star_facts_path
  end
end
