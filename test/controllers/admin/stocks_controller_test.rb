require "test_helper"

class Admin::StocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_stock = admin_stocks(:one)
  end

  test "should get index" do
    get admin_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_stock_url
    assert_response :success
  end

  test "should create admin_stock" do
    assert_difference("Admin::Stock.count") do
      post admin_stocks_url, params: { admin_stock: { amount: @admin_stock.amount, product_id: @admin_stock.product_id, size: @admin_stock.size } }
    end

    assert_redirected_to admin_stock_url(Admin::Stock.last)
  end

  test "should show admin_stock" do
    get admin_stock_url(@admin_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_stock_url(@admin_stock)
    assert_response :success
  end

  test "should update admin_stock" do
    patch admin_stock_url(@admin_stock), params: { admin_stock: { amount: @admin_stock.amount, product_id: @admin_stock.product_id, size: @admin_stock.size } }
    assert_redirected_to admin_stock_url(@admin_stock)
  end

  test "should destroy admin_stock" do
    assert_difference("Admin::Stock.count", -1) do
      delete admin_stock_url(@admin_stock)
    end

    assert_redirected_to admin_stocks_url
  end
end
