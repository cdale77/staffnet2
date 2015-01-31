source "https://rubygems.org"

ruby "2.2.0"
gem "rails", "4.2.0"
gem "rake", "10.4.2"
#gem "unicorn", "4.8.3"
gem "puma", "2.11.0"
gem "rack-timeout", "0.2.0"
gem "pg", "0.18.1"
gem "devise", "3.4.1"
gem "pundit", "0.3.0"
gem "figaro", "1.1.0"
gem "i18n", "0.7.0"
gem "gctools", "0.2.3"
gem "dalli", "2.7.2"

## JOBS
gem "sidekiq", "3.3.1"
gem "sinatra", "1.4.5"  # required by Sidekiq
gem "slim", "2.1.0"     # required by Sidekiq

## MONITORING
gem "exception_notification", "4.0.1"
gem "newrelic_rpm", "3.9.9.275"

## APIs
gem "activemerchant", "1.46.0"
gem "money", "6.5.0"
gem "sendyr", "0.2.1"

# DATA STORAGE
gem "aws-sdk", "1.61.0"
gem "pgbackups-archive", "0.2.1"
gem "paper_trail", "3.0.6"
gem "s3_direct_upload", "0.1.7"
gem "smarter_csv", "1.0.19"
gem "paperclip", "4.2.1"

## DATES
gem "date_validator", "0.7.1"
gem "week_of_month", "1.2.3.2"

## UI
gem "sass-rails", "5.0.1"
gem "bootstrap-sass", "3.3.3"
gem "will_paginate", "3.0.7"
gem "bootstrap-will_paginate", "0.0.10"
gem "simple_form", "3.1.0"
gem "ransack", "1.6.3"

## JS
gem "jquery-rails", "4.0.3"
gem "raphael-rails", "2.1.2"
gem "morrisjs-rails", "0.5.1"

## Misc
gem "axlsx", "2.0.01"
gem "pry-rails", "0.3.2"
#gem "pipl-api", "3.0.1"
#gem "fullcontact", "0.7.0"
#gem "rubillow", git: "https://github.com/cdale77/rubillow.git"

group :development do
  gem "faker", "1.4.3"
  gem "annotate", "2.6.5"
  gem "metric_fu", "4.11.2"
end

group :development, :test do
  gem "rspec-rails", "3.1"
  gem "capybara", "2.4.4"
  gem "selenium-webdriver", "2.44.0"
  gem "factory_girl_rails", "4.5.0"
  gem "byebug", "3.5.1"
  gem "codeclimate-test-reporter", "0.4.6"
end

group :test do
  #gem "webmock", "1.18.0"
  gem "database_cleaner", "1.4.0"
end

group :production do
  gem "rails_12factor", "0.0.3"
end

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "2.5.3"

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
gem "jbuilder", "2.2.6"

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
