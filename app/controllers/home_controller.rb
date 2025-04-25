class HomeController < ApplicationController
  def index
    @categories = Category.all

    @products = Product.all

    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recent"
      @products = @products.where("updated_at >= ?", 3.days.ago)
    end

    @products = @products.page(params[:page]).per(12) # <-- PAGINATION HERE
  end
end
