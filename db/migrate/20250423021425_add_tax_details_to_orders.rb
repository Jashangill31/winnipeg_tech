class AddTaxDetailsToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :gst, :decimal
    add_column :orders, :pst, :decimal
    add_column :orders, :hst, :decimal
    # Comment this line to avoid duplicate column error
    # add_column :orders, :total, :decimal
  end
end
