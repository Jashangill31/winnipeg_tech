require "test_helper"

class Categories::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get categories_products_index_url
    assert_response :success
  end
end
