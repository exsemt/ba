require 'test_helper'

class Star::ProductsControllerTest < ActionController::TestCase
  setup do
    @star_product = star_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:star_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create star_product" do
    assert_difference('Star::Product.count') do
      post :create, star_product: { brand: @star_product.brand, category: @star_product.category, contents: @star_product.contents, name: @star_product.name, price: @star_product.price, product_no: @star_product.product_no }
    end

    assert_redirected_to star_product_path(assigns(:star_product))
  end

  test "should show star_product" do
    get :show, id: @star_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @star_product
    assert_response :success
  end

  test "should update star_product" do
    put :update, id: @star_product, star_product: { brand: @star_product.brand, category: @star_product.category, contents: @star_product.contents, name: @star_product.name, price: @star_product.price, product_no: @star_product.product_no }
    assert_redirected_to star_product_path(assigns(:star_product))
  end

  test "should destroy star_product" do
    assert_difference('Star::Product.count', -1) do
      delete :destroy, id: @star_product
    end

    assert_redirected_to star_products_path
  end
end
