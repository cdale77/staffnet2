module Cim	

  def self.connection
    if Rails.env.production?
      ActiveMerchant::Billing::AuthorizeNetCimGateway.new(  login: ENV['CIM_LOGIN'],
                                                          password: ENV['CIM_PASSWORD'])
    else
      ActiveMerchant::Billing::AuthorizeNetCimGateway.new(  login: ENV['CIM_LOGIN'],
                                                            password: ENV['CIM_PASSWORD'],
                                                            test: true)
    end
  end

  class Profile

    attr_reader :cim_id
    attr_reader :server_message
    attr_reader :success

    def initialize(cim_customer_id, supporter_email = '', cim_id = '')
      @cim_customer_id = cim_customer_id.to_s
      @supporter_email = supporter_email
      @cim_id = cim_id
      @success = false
    end

    def store
      result = Cim.connection.create_customer_profile(profile: customer_profile)
      @server_message = result.message
      if result.params && result.success?
        @success = true
        @cim_id = result.params['customer_profile_id']
      end
    end

    def unstore
      result = Cim.connection.delete_customer_profile(customer_profile_id: @cim_id)
      @server_message = result.message
      @success = result.success?
    end

    private
      def customer_profile
        { merchant_customer_id: @cim_customer_id, email: @supporter_email }
      end
  end

  class PaymentProfile

    attr_reader :success
    attr_reader :cim_payment_profile_id
    attr_reader :server_message

    def initialize(supporter, cc_number = '', cc_month = '', cc_year = '', cc_type = '', cim_payment_profile_id = '')
      @success = false
      @supporter = supporter
      @cc_number = cc_number
      @cc_month = cc_month
      @cc_year = cc_year
      @cc_type = cc_type
      @cim_payment_profile_id = cim_payment_profile_id
    end

    def store
      result = Cim.connection.create_customer_payment_profile({ customer_profile_id: @supporter.cim_id,
                                                                payment_profile: cim_payment_profile })
      @server_message = result.message
      if result.params
        @success = result.success?
        result.success? ? @cim_payment_profile_id = result.params['customer_payment_profile_id'] : false
      end
    end

=begin
    def update
      result = Cim.connection.update_customer_payment_profile({ customer_profile_id: @supporter.cim_id,
                                                                payment_profile: cim_payment_profile })
      @server_message = result.message
      if result.params
        result.success? ? @cim__payment_profile_id = result.params['customer_payment_profile_id']: false
      end
    end
=end

    def unstore
      result = Cim.connection.delete_customer_payment_profile(customer_profile_id: @supporter.cim_id,
                                                              customer_payment_profile_id: @cim_payment_profile_id )
      #@server_message = result.message
      result.success? ? true : false
    end


    private

      def cim_payment_profile
        { bill_to: cim_billing_info, payment: cim_payment_info }
      end

      def cim_billing_info
        {   
          first_name: @supporter.first_name,
          last_name: @supporter.last_name,
          address: @supporter.address1,
          city: @supporter.address_city,
          state: @supporter.address_state,
          country: 'USA',
          zip: @supporter.address_zip,
          phone_number: @supporter.phone_mobile
        }
      end

      def cim_payment_info
        { credit_card: credit_card }
      end

      def credit_card
        ActiveMerchant::Billing::CreditCard.new(  first_name: @supporter.first_name,
                                                  last_name: @supporter.last_name,
                                                  number: @cc_number,
                                                  month: @cc_month.to_i,
                                                  year: @cc_year.to_i,
                                                  brand: @cc_type)
      end

  end

  class ProfilePayment

    attr_reader :cim_transaction_id
    attr_reader :server_message
    attr_reader :cim_auth_code

    def initialize(cim_profile_id, cim_payment_profile_id, amount)
      @cim_profile_id = cim_profile_id
      @cim_payment_profile_id = cim_payment_profile_id
      @amount = amount
      @cim_transaction_id = ''
      @cim_auth_code = ''
    end

    def process
      result = Cim.connection.create_customer_profile_transaction(
          transaction: {
                          type: :auth_capture,
                          amount: @amount,
                          customer_profile_id: @cim_profile_id,
                          customer_payment_profile_id: @cim_payment_profile_id,
                        }
                                                                  )
      if result.params
        @cim_transaction_id = result.params['direct_response']['transaction_id']
        @cim_auth_code = result.params['direct_response']['approval_code']
      end

      @server_message = result.message
      result.success? ? true : false
    end
  end



end