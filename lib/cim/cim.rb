module Cim	


  def self.connection
    ActiveMerchant::Billing::AuthorizeNetCimGateway.new(  login: ENV['CIM_LOGIN'],
                                                            password: ENV['CIM_PASSWORD'],
                                                            test: true )
  end

  class Profile 

    attr_reader :cim_id
    attr_reader :params

    def initialize(supporter_id, supporter_email = '')
      @supporter_id = supporter_id.to_s
      @supporter_email = supporter_email
      @cim_id = ''
      @params = {}
    end

    def store
      result = Cim.connection.create_customer_profile(profile: customer_profile)
      @params = result.params
      @cim_id = result.params['customer_profile_id']
      raise Exceptions::CimProfileError unless @cim_id
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