source "https://rubygems.org"

ruby "2.3.0"
gem "rails", "4.2.6"
gem "rake", "10.5.0"
gem "puma", "3.0.2"
gem "rack-timeout", "0.3.2"
gem "pg", "0.18.4"
gem "devise", "3.5.6"
gem "pundit", "1.1.0"
gem "figaro", "1.1.1"
gem "i18n", "0.7.0"
gem "dalli", "2.7.6"

## JOBS
gem "sidekiq", "4.1.1"
gem "sinatra", "1.4.7"  # required by Sidekiq
gem "slim", "3.0.6"     # required by Sidekiq

## MONITORING
gem "exception_notification", "4.1.4"
gem "newrelic_rpm", "3.15.0.314"

## APIs
gem "activemerchant", "1.58.0"
gem "money", "6.7.0"
gem "sendyr", "0.2.1"

# DATA STORAGE
gem "aws-sdk", "< 2.0"
gem "pgbackups-archive", "0.2.1"
gem "paper_trail", "3.0.8"
gem "s3_direct_upload", "0.1.7"
gem "smarter_csv", "1.1.0"
gem "paperclip", "4.3.5"

## DATES
gem "date_validator", "0.9.0"
gem "week_of_month", "1.2.3.4"

## UI
gem "bootstrap-sass", "3.3.6"
gem "sass-rails", "5.0.4"
gem "will_paginate", "3.1.0"
gem "bootstrap-will_paginate", "0.0.10"
gem "simple_form", "3.2.1"
gem "ransack", "1.7.0"

## JS
gem "jquery-rails", "4.1.0"
gem "raphael-rails", "2.1.2"
gem "morrisjs-rails", "0.5.1"

## Misc
gem "axlsx", "2.0.01"
gem "pry-rails", "0.3.4"

group :development do
  gem "faker", "1.6.3"
  gem "annotate", "2.7.0"
  gem "metric_fu", "4.12.0"
end

group :development, :test do
  gem "rspec-rails", "3.4.2"
  gem "capybara", "2.6.2"
  gem "selenium-webdriver", "2.52.0"
  gem "factory_girl_rails", "4.6.0"
  gem "codeclimate-test-reporter", "0.5.0"
end

group :test do
  gem "database_cleaner", "1.5.1"
end

group :production do
  gem "rails_12factor", "0.0.3"
end

gem "uglifier", "2.7.2"
gem "coffee-rails", "4.1.1"

gem "turbolinks", "2.5.3"

gem "jbuilder", "2.4.1"

group :doc do
  gem "sdoc", require: false
end
