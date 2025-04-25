Rails.application.routes.draw do
  # Home
  root "home#index"
  get "home/index"

  # Static Pages using slug
  get "/about", to: "pages#show", defaults: { slug: "about" }, as: :about_page
  get "/contact", to: "pages#show", defaults: { slug: "contact" }, as: :contact_page

  # Product Search
  get "search", to: "products#search", as: :search_products

  # Devise Authentication for Customers
  devise_for :customers, controllers: {
    registrations: "customers/registrations"
  }

  # Devise Authentication for Admin Users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Customer Profile
  get "customers/show", to: "customers#show", as: :customer_profile
  get "customers/edit", to: "customers#edit", as: :edit_customer_profile
  patch "customers/update", to: "customers#update", as: :update_customer_profile

  # Shopping Cart and Cart Items
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]

  # Categories and Nested Product Listing
  resources :categories do
    get "products", to: "categories/products#index", as: :products
  end

  # Product Resource
  resources :products

  # Orders and Checkout
  resources :orders, only: [:new, :create, :show]
  get "checkout", to: "orders#new", as: :checkout
  post "checkout", to: "orders#create"
  post "/orders/:id/pay", to: "orders#pay", as: :pay_order

  # Health Check and PWA Manifest
  get "up", to: "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
end
