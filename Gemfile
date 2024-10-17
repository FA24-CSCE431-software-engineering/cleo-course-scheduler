source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem 'rubocop', require: false
gem 'rexml'
gem 'zeitwerk', '< 2.7.0'

# Add net-pop with a specific version

# Other gems...
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'dotenv-rails', groups: [:development, :test]
gem 'bootstrap', '~> 5.0.0'
gem 'sassc-rails'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 7.0.0"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "simplecov", require: false
  gem 'rails-controller-testing'
end

gem "net-pop", github: "ruby/net-pop"
gem 'jquery-rails'
gem 'csv'
gem 'prawn'

# For course selection search function
gem 'select2-rails'