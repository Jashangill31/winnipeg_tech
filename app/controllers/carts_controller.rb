class CartsController < ApplicationController
  def show
    @cart_items = []
    (session[:cart] || {}).each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        @cart_items << {
          product: product,
          quantity: quantity
        }
      end
    end
  end
end
