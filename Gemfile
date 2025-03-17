# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.4.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

gem 'dotenv-rails'
gem 'kaminari'
gem 'omniauth-discord'
gem 'omniauth-rails_csrf_protection'
gem 'ransack'
gem 'redcarpet'
gem 'slim-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails', '~> 3.0'
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
end

group :development do
  gem 'dockerfile-rails', '>= 1.7'
  gem 'html2slim', require: false, github: 'slim-template/html2slim'
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-fjord', '~> 0.3.0', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'slim_lint', require: false
  gem 'table_print', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
end

