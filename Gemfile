source "https://rubygems.org"

ruby "2.1.2"
gem "rails", "4.2.0.beta1"
gem "rake", "10.3.2"
gem "unicorn", "4.8.3"
gem "sidekiq", "3.2.5"
gem "sinatra", "1.4.5"  # required by Sidekiq
gem "slim", "2.0.3"     # required by Sidekiq
gem "pg", "0.17.1"
# https://github.com/plataformatec/devise/pull/3153
gem "devise", git: "https://github.com/plataformatec/devise.git",
    branch: "lm-rails-4-2"
gem "pundit", "0.3.0"
gem "figaro", "0.7.0"
gem "i18n", "0.7.0.beta1"
gem "newrelic_rpm", "3.9.4.245"


## APIs
gem "activemerchant", "1.44.1"
gem "money", git: "https://github.com/cdale77/money.git"
gem "sendyr", "0.2.1"

# data storage
gem "aws-sdk", "1.53.0"
gem "pgbackups-archive", "0.2.1"
gem "paper_trail", "3.0.5"

## DATES
gem "date_validator", "0.7.0"
gem "week_of_month", "1.2.3.2"

## UI
gem "sass-rails", "5.0.0.beta1"
gem "bootstrap-sass", "3.2.0.2"
gem "will_paginate", "3.0.7"
gem "bootstrap-will_paginate", "0.0.10"
gem "simple_form", "3.1.0.rc2"
#gem "ransack", "1.3.0"
gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4.2"

## JS
gem "jquery-rails", "3.1.2"
gem "raphael-rails", "2.1.2"
gem "morrisjs-rails", "0.5.1"

## Misc
gem "pry-rails", "0.3.2"

group :development do
  gem "faker", "1.4.3"
  gem "annotate", "2.6.5"
  gem "metric_fu", "4.11.1"
end

group :development, :test do
  gem "rspec-rails", "3.1.0"
  gem "capybara", "2.4.1"
  gem "selenium-webdriver", "2.43.0"
  gem "factory_girl_rails", "4.4.1"
  gem "byebug", "3.4.0"
  gem "codeclimate-test-reporter", "0.4.0"
end

group :production do
  gem "rails_12factor", "0.0.2"
end

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "2.5.3"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "4.0.1"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
#gem "jquery-rails"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks", "2.3.0"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "2.1.3"

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