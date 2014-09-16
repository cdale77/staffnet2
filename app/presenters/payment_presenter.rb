class PaymentPresenter < PresenterBase

  def initialize(payment)
    @donation = payment.donation
    @shift = @donation.shift
    super
  end

  def credited_employee
    @shift ? @shift.employee.full_name : "Not credited"
  end

  def shift_date
    @shift ? I18n.l(@shift.date) : "Not applicable"
  end

  def supporter_name
    @donation.supporter.full_name
  end

  def captured_to_human
    captured ? "Yes" : "No"
  end

  def formatted_amount
    number_to_currency(amount)
  end

  def type_to_human
    payment_type.humanize
  end

  def frequency_to_human
    @donation.frequency.humanize
  end

  def source_to_human
    @donation.source.humanize
  end
end