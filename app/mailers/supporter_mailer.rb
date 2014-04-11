class SupporterMailer < ActionMailer::Base
  default from: "campaign@evolve-ca.org"

  def receipt(supporter, donation)
    @message = ReceiptEmail.new(supporter, donation)
    mail( to:       supporter.email_1,
          from:     "Evolve Team <campaign@evolve-ca.org>",
          subject:  "Receipt and thanks!")
  end

  def prospect(message)
    @message = message
    if @message.supporter.email_1
      mail( to:       @message.supporter.email_1,
            from:     @message.employee.email,
            subject:  "Help Reform Prop 13!")
    end
  end

  def pledge(message)
    @message = message

  end


end
