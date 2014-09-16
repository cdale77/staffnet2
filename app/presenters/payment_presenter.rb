class PaymentPresenter < PresenterBase

  def credited_employee
    donation.shift ? donation.shift.employee.full_name : "Not credited"
  end

  def shift_date
    donation.shift ? I18n.l(donation.shift.date) : "Not applicable"
  end

  def supporter_name
    donation.supporter.full_name
  end

  def captured_to_human
    captured ? "Yes" : "No"
  end


  def type_to_human
    payment_type.humanize
  end

  def frequency_to_human
    donation.frequency.humanize
  end

  def source_to_human
    donation.source.humanize
  end
end