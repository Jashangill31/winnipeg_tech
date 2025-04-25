ActiveAdmin.register Customer do
    permit_params :first_name, :last_name, :email, :address, :province_id
  end
  