class PaymentPresenter < FinancePresenter

  def credited_employee
    donation.shift ? donation.shift.employee.full_name : "Not credited"
  end

  def shift_date
    donation.shift ? I18n.l(donation.shift.date) : "Not applicable"
  end

  def supporter_name
    donation.supporter ? donation.supporter.full_name : "No supporter"
  end

  def captured_to_human
    captured ? "Captured" : "Declined"
  end

  def type_to_human
    payment_type.humanize
  end

  def frequency_to_human
    # donation#frequency is a method that always returns a string
    donation.frequency.humanize
  end

  def source_to_human
    donation.source ? donation.source.humanize : ""
  end

  def formatted_donation_amount
    number_to_currency(donation.amount)
  end

  def payment_status
    processed ? "Processed" : "Not processed"
  end

  def formatted_receipt_sent_at
    receipt_sent_at ? I18n.l(receipt_sent_at, format: :long) : "Not sent."
  end

  def formatted_donation_date
    donation_date ? I18n.l(donation.date) : ""
  end

  def is_donation_sustainer?
    donation.is_sustainer?
  end

  def donation_sub_month
    donation.sub_month
  end

  def donation_sub_week
    donation.sub_week
  end

  def payment_profile_short
    payment_profile ? payment_profile.short_version : "No profile"
  end

  def formatted_deposited_at
    deposited_at ? I18n.l(deposited_at) : ""
  end

  def cim_payment_profile_id
    payment_profile ? payment_profile.cim_payment_profile_id : ""
  end
end
