class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :province

  # ✅ Allow Ransack to filter on these attributes
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      customer_id
      status
      gst
      pst
      hst
      total
      created_at
      updated_at
    ]
  end

  # ✅ Allow Ransack to join these associations for filtering
  def self.ransackable_associations(auth_object = nil)
    %w[
      customer
      order_items
      products
      province
    ]
  end
end
