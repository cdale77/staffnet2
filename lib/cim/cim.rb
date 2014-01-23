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
        @cim_id = result.params['customer_profile_id']
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


end