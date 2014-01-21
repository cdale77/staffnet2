module Cim	


	class Connection

		def initialize
      ActiveMerchant::Billing::AuthorizeNetCimGateway.new(  login: ENV['CIM_LOGIN'],
                                                            password: ENV['CIM_PASSWORD'])
		end
	end
end