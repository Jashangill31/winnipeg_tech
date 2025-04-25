class Product < ApplicationRecord
  belongs_to :category
  # Uncomment if you're using ActiveStorage for images
  # has_one_attached :image

  # Allow Ransack to search associations like category
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  # Allow Ransack to filter/search these attributes (include sale_price)
  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "description",
      "price",
      "sale_price",
      "stock",
      "category_id",
      "created_at",
      "updated_at"
    ]
  end

  # Validations
  validates :name, :description, :price, :stock, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
