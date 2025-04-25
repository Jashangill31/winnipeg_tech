class CartItemsController < ApplicationController
  def create
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    session[:cart] ||= {}

    if session[:cart][product_id]
      session[:cart][product_id] += quantity
    else
      session[:cart][product_id] = quantity
    end

    redirect_to products_path, notice: "Item added to cart!"
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if session[:cart] && session[:cart][product_id]
      session[:cart][product_id] = quantity
    end

    redirect_to carts_show_path, notice: "Cart updated!"
  end

  def destroy
    product_id = params[:product_id].to_s
    session[:cart]&.delete(product_id)

    redirect_to carts_show_path, notice: "Item removed from cart!"
  end
end
