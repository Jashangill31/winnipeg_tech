class HomeController < ApplicationController
    def index
      @categories = Category.all
      @products = Product.all
    end
  
    def category
      @category = Category.find(params[:id])
      @products = @category.products
    end
  end
  