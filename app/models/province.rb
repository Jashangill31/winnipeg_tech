class Province < ApplicationRecord
    has_many :orders
  
    def self.ransackable_attributes(auth_object = nil)
      %w[id name gst pst hst created_at updated_at]
    end
  
    def self.ransackable_associations(auth_object = nil)
      %w[orders]
    end
  end
  