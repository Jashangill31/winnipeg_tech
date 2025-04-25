def update
    product_id = params[:id]
    quantity = params[:quantity].to_i
  
    if session[:cart] && session[:cart][product_id]
      session[:cart][product_id] = quantity
    end
  
    redirect_to cart_path, notice: "Cart updated successfully."
  end
  