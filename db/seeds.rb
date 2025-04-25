# Clear dependent records first (safe order)
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Page.destroy_all if defined?(Page)

# Only destroy provinces if no customers reference them
if Customer.count == 0
  Province.destroy_all
end

# Seed provinces (skip if they exist already)
if Province.count == 0
  Province.create!([
    { name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0 },
    { name: "Ontario", gst: 0, pst: 0, hst: 0.13 },
    { name: "Alberta", gst: 0.05, pst: 0, hst: 0 }
  ])
end

# Seed categories
categories = [
  Category.create!(name: 'Laptops'),
  Category.create!(name: 'Gaming Consoles'),
  Category.create!(name: 'Accessories'),
  Category.create!(name: 'Networking Equipment')
]

# Seed products using Faker (no images)
require 'faker'
100.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 100..1000.0),
    stock: rand(0..100),
    category: categories.sample
  )
end

# Seed About and Contact static pages if Page model exists
if defined?(Page)
  Page.create!(
    title: "About Us",
    content: "Winnipeg Tech Hub is a local electronics retailer committed to providing quality laptops, gaming consoles, accessories, and networking gear. We believe in service, selection, and value.",
    slug: "about"
  )

  Page.create!(
    title: "Contact Us",
    content: "For inquiries, please reach out to us at support@winnipegtechhub.ca or visit us at 123 Tech Avenue, Winnipeg, MB.",
    slug: "contact"
  )
end

# Final output
puts "✅ Seeded:"
puts "- #{Province.count} provinces"
puts "- #{Category.count} categories"
puts "- #{Product.count} products"
puts "- #{Page.count if defined?(Page)} pages"
