class SupporterPresenter < PresenterBase

  def formatted_city_state_zip
    "#{address_city}, #{address_state} #{address_zip}"
  end

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
end
