module Categories
  class ProductsController < ApplicationController
    def index
      @category = Category.find(params[:category_id])
      @products = @category.products.page(params[:page]).per(12)
    end
  end
end
