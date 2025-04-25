class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Ransack whitelisting: prevent Devise-sensitive fields from being searchable
  def self.ransackable_attributes(auth_object = nil)
    %w[id first_name last_name email address province_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[province orders]
  end
end
