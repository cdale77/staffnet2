class PeoplePresenter < PresenterBase

  def formatted_city_state_zip
    "#{address_city}, #{address_state} #{address_zip}"
  end

end