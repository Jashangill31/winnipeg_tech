ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :sale_price

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :sale_price
    column :stock
    column :category
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :sale_price
  filter :stock
  filter :category

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :sale_price
      f.input :stock
      f.input :category
      # f.input :image, as: :file (Uncomment if you re-enable image upload)
    end
    f.actions
  end
end
