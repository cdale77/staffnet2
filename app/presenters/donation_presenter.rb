class DonationPresenter < FinancePresenter

  def supporter_full_name
    supporter ? supporter.full_name : "No supporter"
  end

  def type_to_human
    donation_type.humanize
  end

  def source_to_human
    source.humanize
  end

  def campaign_to_human
    campaign.humanize
  end

  def cancelled_to_human
    cancelled ? "Yes" : "No"
  end

  def captured_to_human
    captured ? "Yes" : "No"
  end

  def frequency_to_human
    frequency.humanize
  end
end
