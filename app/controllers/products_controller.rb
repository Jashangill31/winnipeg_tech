class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recent"
      @products = @products.where("updated_at >= ?", 3.days.ago)
    end

    @products = @products.page(params[:page]).per(12)
  end

  def search
    @categories = Category.all
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("name ILIKE ? OR description ILIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end
