module Cim	


  def self.connection
    ActiveMerchant::Billing::AuthorizeNetCimGateway.new(  login: ENV['CIM_LOGIN'],
                                                            password: ENV['CIM_PASSWORD'],
                                                            test: true )
  end

  class Profile 

    attr_reader :cim_id
    attr_reader :server_message

    def initialize(supporter_id, supporter_email = '', cim_id = '')
      @supporter_id = supporter_id.to_s
      @supporter_email = supporter_email
      @cim_id = cim_id
      @server_message = ''
    end

    def store
      result = Cim.connection.create_customer_profile(profile: customer_profile)
      @server_message = result.message
      if result.success?
        @cim_id = result.params['customer_profile_id'] if result.params
      else
        raise Exceptions::CimProfileError
        return false
      end
    end

    def unstore
      result = Cim.connection.delete_customer_profile(customer_profile_id: @cim_id)
      if result.success?
        return true
      else
        raise Exceptions::CimProfileError
        return false
      end
    end

    private
      def customer_profile
        { 
          merchant_customer_id: @supporter_id,
          email: @supporter_email
        }
      end
  end

  class PaymentProfile

    def initialize(supporter, cc_number = '', cc_month = '', cc_year = '', cc_type = '' )
      @supporter = supporter
      @cc_number = cc_number
      @cc_month = cc_month
      @cc_year = cc_year
      @cc_type = cc_type
      @payment_profile_id = ''
    end

    def store
      result = Cim.connection.create_customer_payment_profile({ customer_profile_id: @supporter.cim_id,
                                                                payment_profile: cim_payment_profile } )
      result
    end

    #private

      def cim_payment_profile
        {
          bill_to: cim_billing_info,
          payment: cim_payment_info
        }
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
       # card = credit_card
       # {
       #   first_name: card.first_name,
       #   last_name: card.last_name,
       #   number: card.number,
       #   month: card.month,
       #   year: card.year,
       #   brand: card.brand
        #}
        {
            credit_card: credit_card
        }
      end

      def credit_card
        ActiveMerchant::Billing::CreditCard.new(
          first_name: @supporter.first_name,
          last_name: @supporter.last_name,
          number: @cc_number,
          month: @cc_month.to_i,
          year: @cc_year.to_i,
          brand: @cc_type)
      end

  end

  ## old code


  class OldCode

    def self.create_payment_profile(supporter, payment, cc)
      result = connection.create_customer_payment_profile(cim_options(supporter, payment, cc))
      #payment.authorize_payment_profile_id = result.params['customer_payment_profile_id']
      #payment.save
      result.params['customer_payment_profile_id']
    end

    def self.connection
      ActiveMerchant::Billing::AuthorizeNetCimGateway.new(login: ENV['CIM_LOGIN'],
          password: ENV['CIM_PASSWORD'],
          test: true)
    end

    def self.billing_info(supporter)
      supporter = supporter
      {   :first_name => supporter.first_name,
          :last_name => supporter.last_name,
          :address => supporter.address1,
          :city => supporter.address_city,
          :state => supporter.address_state,
          :country => 'USA',
          :zip => supporter.address_zip,
          :phone_number => supporter.phone_mobile
      }
    end

    def self.credit_card(supporter, payment, cc)
      new_card = ActiveMerchant::Billing::CreditCard.new(
          :first_name => supporter.first_name,
          :last_name => supporter.last_name,
          :number => cc,
          :month => payment.cc_month.to_i,
          :year => payment.cc_year.to_i,
          :brand => payment.cc_type)
      {
          :first_name => new_card.first_name,
          :last_name => new_card.last_name,
          :number => new_card.number,
          :month => new_card.month,
          :year => new_card.year,
          :brand => new_card.brand
      }
    end

    def self.cim_options(supporter, payment, cc)
      {
          :customer_profile_id => supporter.cim_id,
          :payment_profile => package_cim_profile(supporter, payment, cc)
      }
    end

    def self.package_cim_profile(supporter, payment, cc)
      {
          :bill_to => billing_info(supporter),
          :payment => credit_card(supporter, payment, cc)
      }
    end

  end



end