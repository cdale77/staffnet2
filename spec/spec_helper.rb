# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #config.include(EmailSpec::Helpers)
  #config.include(EmailSpec::Matchers)
  
  config.before(:each) do
    stub_request( :post, "https://apitest.authorize.net/xml/v1/request.api").
         with(  headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return( status: 200, body: '<?xml version="1.0" encoding="utf-8"?>
                                        <createCustomerProfileResponse>
                                          <messages>
                                            <resultCode>Ok</resultCode>
                                            <message>
                                              <code>I00001</code>
                                              <text>Successful.</text>
                                            </message>
                                          </messages>
                                          <customerProfileId>10793616</customerProfileId>
                                          <customerPaymentProfileIdList/>
                                          <customerShippingAddressIdList/>
                                          <validationDirectResponseList/>
                                        </createCustomerProfileResponse>',
                    headers: { 'Content-Type' => 'text/xml' })
  end


  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
