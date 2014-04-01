class SupporterMailer < ActionMailer::Base
  default from: "campaign@evolve-ca.org"

  def receipt(supporter, donation)
    @message = ReceiptEmail.new(supporter, donation)
    mail( to:       supporter.email_1,
          from:     "Evolve Team <campaign@evolve-ca.org>",
          subject:  "Receipt and thanks!")
  end


end
