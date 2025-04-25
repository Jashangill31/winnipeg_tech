# Gemfile

source "https://rubygems.org"

# Core Rails dependencies
gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "pg", "~> 1.1"                  # PostgreSQL database
gem "puma", ">= 5.0"                # Web server
gem "sprockets-rails"              # Asset pipeline for Rails
gem "importmap-rails"              # JS import maps
gem "turbo-rails"                  # Turbo for Hotwire
gem "stimulus-rails"               # Stimulus JS for frontend logic
gem "jbuilder"                     # JSON response builder
gem "bootsnap", require: false     # Speeds up boot time
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# Frontend enhancements
gem "sassc"                        # Sass compiler (needed by ActiveAdmin)

# Admin Dashboard
gem "activeadmin", "~> 3.3"

# Authentication
gem "devise"                       # For both customers and admin users

# Pagination
gem "kaminari"

# Payment integration
gem "stripe"                       # Stripe payment gateway

# Environment variables
gem "dotenv-rails"                 # Load Stripe keys and other env vars

# Environment-specific gems
group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ], require: "debug/prelude"
  gem "brakeman", require: false                  # Security analyzer
  gem "rubocop-rails-omakase", require: false     # Linting
end

group :development do
  gem "faker"                        # Seed data generator
  gem "web-console"                 # Console in the browser
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "capybara"                    # Feature testing
  gem "selenium-webdriver"         # Browser automation
end
