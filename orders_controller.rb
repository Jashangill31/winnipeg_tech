class OrdersController < ApplicationController
    before_action :authenticate_customer!
  
    def new
      @order = Order.new
      @provinces = Province.all
    end
  
    def create
      # 1. Update customer info if missing
      if current_customer.address.blank? && params[:address].present?
        current_customer.update!(
          first_name: params[:first_name],
          last_name: params[:last_name],
          address: params[:address],
          city: params[:city],
          postal_code: params[:postal_code],
          province_id: params[:province_id]
        )
      end
  
      province = current_customer.province
      cart = session[:cart] || {}
      subtotal = 0
  
      # 2. Create order
      order = current_customer.orders.create!(
        status: 'new'
      )
  
      # 3. Add items to order
      cart.each do |product_id, quantity|
        product = Product.find(product_id)
        quantity = quantity.to_i
        subtotal += product.price * quantity
  
        order.order_items.create!(
          product: product,
          quantity: quantity,
          price: product.price
        )
      end
  
      # 4. Calculate taxes
      gst = subtotal * province.gst
      pst = subtotal * province.pst
      hst = subtotal * province.hst
      total = subtotal + gst + pst + hst
  
      # 5. Update order totals
      order.update!(
      gst: gst,
      pst: pst,
      hst: hst,
      total: total
      )  

  
      # 6. Clear cart and redirect
      session[:cart] = {}
      redirect_to order_path(order), notice: "Order placed successfully!"
    end
  
    def show
      @order = Order.find(params[:id])
    end
  end
  