ActiveAdmin.register Order do
  permit_params :status, :customer_id, :shipping_address, :province_id, :gst, :pst, :hst, :total

  index do
    selectable_column
    id_column
    column :customer do |order|
      "#{order.customer.first_name} #{order.customer.last_name}"
    end
    column :status
    column :total
    column :created_at
    actions
  end

  filter :customer_email, as: :string
  filter :status, as: :select, collection: ['new', 'paid', 'shipped']
  filter :created_at

  show do
    attributes_table do
      row :id
      row :customer do |order|
        "#{order.customer.first_name} #{order.customer.last_name}"
      end
      row :shipping_address
      row :province
      row :gst
      row :pst
      row :hst
      row :total
      row :status
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price
      end
    end
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :status, as: :select, collection: ['new', 'paid', 'shipped'], include_blank: false
    end
    f.actions
  end
end
