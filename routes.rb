Rails.application.routes.draw do
  # Home Page
  root "home#index"
  get "home/index"

  # Static Pages (via dynamic slug-based show)
  get "pages/:slug", to: "pages#show", as: :page

  # Product Search
  get "search", to: "products#search", as: :search_products

  # Shopping Cart
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]

  # Categories + Nested Products
  resources :categories do
    resources :products, only: [:index], controller: "categories/products"
  end

  # Products
  resources :products

  # Orders + Checkout
  resources :orders, only: [:new, :create, :show]
  get "checkout", to: "orders#new", as: :checkout
  post "checkout", to: "orders#create"
  post "/orders/:id/pay", to: "orders#pay", as: :pay_order

  # Customer Authentication & Profile
  devise_for :customers
  resource :customer, only: [:show, :edit, :update]

  # Admin Authentication & Dashboard
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Health Check + PWA Support
  get "up", to: "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
end
