require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Staffnet2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.i18n.enforce_available_locales = true

    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.filter_parameters += [:password, :password_confirmation, :cc_number]
    config.autoload_paths += %W(#{config.root}/lib/validations)
    config.autoload_paths += %W(#{config.root}/lib/mail_chimp)
    config.autoload_paths += %W(#{config.root}/lib/cim)
    config.autoload_paths += %W(#{config.root}/app/models/emails)
    config.autoload_paths += %W(#{config.root}/app/models/legacy)

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs false
      g.helper_specs false
      g.stylesheets = false
      g.javascripts = false
      g.helper = false
    end

    ## SETTINGS

    config.user_roles = %w[staff manager admin super_admin]

    config.minimum_wage = 10.55



  end
end
