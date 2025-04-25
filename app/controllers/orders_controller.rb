class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @provinces = Province.all
  end

  def create
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

    order = current_customer.orders.create!(
      shipping_address: current_customer.address,
      province_id: province.id,
      status: "new"
    )

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

    gst = subtotal * province.gst
    pst = subtotal * province.pst
    hst = subtotal * province.hst
    total = subtotal + gst + pst + hst

    order.update!(
      gst: gst,
      pst: pst,
      hst: hst,
      total: total
    )

    session[:cart] = {}
    redirect_to order_path(order), notice: "Order placed successfully!"
  end

  def pay
    @order = Order.find(params[:id])

    begin
      charge = Stripe::Charge.create(
        amount: (@order.total * 100).to_i,
        currency: "cad",
        source: params[:stripeToken],
        description: "Payment for Order ##{@order.id}"
      )

      @order.update!(status: "paid", stripe_payment_id: charge.id)
      redirect_to order_path(@order), notice: "Payment successful!"
    rescue Stripe::CardError => e
      redirect_to order_path(@order), alert: e.message
    end
  end
end
