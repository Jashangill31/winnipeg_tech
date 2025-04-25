class AddDetailsToCustomers < ActiveRecord::Migration[7.2]
  def change
    # Remove these lines if the columns already exist
    # add_column :customers, :first_name, :string
    # add_column :customers, :last_name, :string
    # add_column :customers, :address, :string
    # add_column :customers, :city, :string
    # add_column :customers, :postal_code, :string

    # Only add reference if it's not yet in the table
    unless column_exists?(:customers, :province_id)
      add_reference :customers, :province, null: false, foreign_key: true
    end
  end
end
