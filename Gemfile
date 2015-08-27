source "https://rubygems.org"

ruby "2.2.2"
gem "rails", "4.2.3"
gem "rake", "10.4.2"
gem "puma", "2.12.3"
gem "rack-timeout", "0.2.4"
gem "pg", "0.18.2"
gem "devise", "3.5.1"
gem "pundit", "0.3.0"
gem "figaro", "1.1.1"
gem "i18n", "0.7.0"
gem "dalli", "2.7.4"

## JOBS
gem "sidekiq", "3.4.2"
gem "sinatra", "1.4.6"  # required by Sidekiq
gem "slim", "3.0.6"     # required by Sidekiq

## MONITORING
gem "exception_notification", "4.1.1"
gem "newrelic_rpm", "3.13.0.299"

## APIs
gem "activemerchant", "1.52.0"
gem "money", "6.6.1"
gem "sendyr", "0.2.1"

# DATA STORAGE
gem "aws-sdk", "< 2.0"
gem "pgbackups-archive", "0.2.1"
gem "paper_trail", "3.0.8"
gem "s3_direct_upload", "0.1.7"
gem "smarter_csv", "1.1.0"
gem "paperclip", "4.3.0"

## DATES
gem "date_validator", "0.8.1"
gem "week_of_month", "1.2.3.2"

## UI
gem "bootstrap-sass", "3.3.5.1"
gem "sass-rails", "5.0.3"
gem "will_paginate", "3.0.7"
gem "bootstrap-will_paginate", "0.0.10"
gem "simple_form", "3.1.0"
gem "ransack", "1.6.6"

## JS
gem "jquery-rails", "4.0.3"
gem "raphael-rails", "2.1.2"
gem "morrisjs-rails", "0.5.1"

## Misc
gem "axlsx", "2.0.01"
gem "pry-rails", "0.3.4"
gem "celluloid", "<= 0.17.0" # version 0.16.0 yanked, sidekiq 3.4.2 requires it.
#gem "pipl-api", "3.0.1"
#gem "fullcontact", "0.7.0"
#gem "rubillow", git: "https://github.com/cdale77/rubillow.git"

group :development do
  gem "faker", "1.4.3"
  gem "annotate", "2.6.10"
  gem "metric_fu", "4.12.0"
end

group :development, :test do
  gem "rspec-rails", "3.3.3"
  gem "capybara", "2.4.4"
  gem "selenium-webdriver", "2.47.1"
  gem "factory_girl_rails", "4.5.0"
  gem "byebug", "5.0.0"
  gem "codeclimate-test-reporter", "0.4.7"
end

group :test do
  #gem "webmock", "1.18.0"
  gem "database_cleaner", "1.4.1"
end

group :production do
  gem "rails_12factor", "0.0.3"
end

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "2.7.1"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "4.1.0"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
#gem "jquery-rails"

# Turbolinks makes following links in your web application faster. 
# Read more: https://github.com/rails/turbolinks
gem "turbolinks", "2.5.3"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "2.3.1"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc", require: false
end

# Use ActiveModel has_secure_password
# gem "bcrypt-ruby", "~> 3.0.0"

# Use unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano", group: :development

# Use debugger
# gem "debugger", group: [:development, :test]
