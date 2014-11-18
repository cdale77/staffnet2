class SupporterPresenter < PeoplePresenter

  def occupation_to_human
    occupation.humanize
  end

  def source_to_human
    source.humanize
  end

  def phone_mobile_to_human
    number_to_phone(phone_mobile.to_i)
  end

  def supporter_type_name
     supporter_type ? supporter_type.name.humanize : ""
  end

  def formatted_sendy_status
    if sendy_status == "subscribe" || sendy_status == "unsubscribe"
      "#{sendy_status.humanize}d"
    else
      sendy_status.humanize
    end
  end
end

