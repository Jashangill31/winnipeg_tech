ActiveAdmin.register OrderItem do
  permit_params :order_id, :product_id, :quantity, :price

  # Optional: Customize the form
  form do |f|
    f.inputs "Order Item Details" do
      f.input :order
      f.input :product
      f.input :quantity
      f.input :price
    end
    f.actions
  end
end
