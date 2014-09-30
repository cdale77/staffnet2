class ReceiptEmail
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :supporter_first_name, :supporter_last_name,
                :donation_type, :donation_amount, :donation_captured, :donation_sustainer, :donation_auth_code,
                :donation_date, :donation_frequency, :donation_cc_type

  def initialize(supporter, donation, cim_auth_code)
    msg_attrs = receipt_attributes(supporter, donation, cim_auth_code)
    msg_attrs.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  private

    # Receipts are only sent if the donation is captured. 
    def receipt_attributes(supporter, donation, payment, cim_auth_code)
      {
          supporter_first_name: supporter.first_name,
          supporter_last_name:  supporter.last_name,
          donation_type:        donation.donation_type,
          donation_amount:      donation.amount,
          donation_captured:    true,
          donation_sustainer:   donation.is_sustainer?,
          donation_auth_code:   cim_auth_code,
          donation_date:        donation.date,
          donation_frequency:   donation.frequency
      }
    end
end
