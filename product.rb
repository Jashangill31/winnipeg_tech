scope :on_sale, -> { where.not(sale_price: nil).where("sale_price < price") }
