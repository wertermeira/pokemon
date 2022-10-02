# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt'
# About CSV Reading and Writing
gem 'csv', '~> 3.2', '>= 3.2.5'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps
gem 'kaminari'
# Object-based searching. http://ransack-demo.herokuapp.com
gem 'ransack'
# ActiveModel::Serializer implementation and Rails hooks
gem 'active_model_serializers', '~> 0.10.12'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.4', '>= 1.4.3'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'brakeman'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rails_config'
  gem 'rubocop-rspec'
  gem 'simplecov'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end
