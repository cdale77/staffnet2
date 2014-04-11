class ReceiptEmail
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :supporter_first_name, :supporter_last_name,
                :donation_type, :donation_amount, :donation_captured, :donation_sustainer, :donation_auth_code,
                :donation_date, :donation_frequency, :donation_cc_type

  def initialize(supporter, donation)
    msg_attrs = receipt_attributes(supporter, donation, donation.payments.first)
    msg_attrs.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  private

    def receipt_attributes(supporter, donation, payment)
      {
          supporter_first_name: supporter.first_name,
          supporter_last_name:  supporter.last_name,
          donation_type:        donation.donation_type,
          donation_amount:      donation.amount,
          donation_captured:    payment.captured,
          donation_sustainer:   donation.is_sustainer?,
          donation_auth_code:   payment.cim_auth_code,
          donation_date:        donation.date,
          donation_frequency:   donation.frequency
      }
    end
end