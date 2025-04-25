class CartController < ApplicationController
    def show
      @cart_items = session[:cart] || {}
      @products = Product.where(id: @cart_items.keys)
    end
  end
  