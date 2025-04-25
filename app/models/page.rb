class Page < ApplicationRecord
    # Add this method so Ransack knows what is searchable
    def self.ransackable_attributes(auth_object = nil)
      ["id", "title", "content", "slug", "created_at", "updated_at"]
    end
  end
  