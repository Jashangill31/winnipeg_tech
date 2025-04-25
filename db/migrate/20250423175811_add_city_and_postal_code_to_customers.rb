class AddCityAndPostalCodeToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :city, :string
    add_column :customers, :postal_code, :string
  end
end
