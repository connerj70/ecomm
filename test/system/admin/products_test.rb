require "application_system_test_case"

class Admin::ProductsTest < ApplicationSystemTestCase
  setup do
    @admin_product = admin_products(:one)
  end

  test "visiting the index" do
    visit admin_products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit admin_products_url
    click_on "New product"

    check "Active" if @admin_product.active
    fill_in "Category", with: @admin_product.category_id
    fill_in "Description", with: @admin_product.description
    fill_in "Name", with: @admin_product.name
    fill_in "Price", with: @admin_product.price
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit admin_product_url(@admin_product)
    click_on "Edit this product", match: :first

    check "Active" if @admin_product.active
    fill_in "Category", with: @admin_product.category_id
    fill_in "Description", with: @admin_product.description
    fill_in "Name", with: @admin_product.name
    fill_in "Price", with: @admin_product.price
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit admin_product_url(@admin_product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
