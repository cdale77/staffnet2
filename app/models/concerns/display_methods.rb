module DisplayMethods
  extend ActiveSupport::Concern


  ## DISPLAY METHODS
  ## These methods return collections of attributes for easy views
  def phones
    phone_fields = [:phone_mobile, :phone_home, :phone_alt]
    result = {}
    phone_fields.each do |field|
      phone_number = send(field.to_s)
      result[field] = phone_number unless phone_number.blank? || send("#{field.to_s}_bad")
    end
    result
  end

  def emails
    email_fields = [:email_1, :email_2]
    result = {}
    email_fields.each do |field|
      email = send(field.to_s)
      result[field] = email unless email.blank? || send("#{field.to_s}_bad")
    end
    result
  end

  def contact_prefs
    pref_fields = [:do_not_mail, :do_not_call, :do_not_email]
    result = {}
    pref_fields.each do |field|
      result[:field] = field.to_s unless send("#{field.to_s}")
    end
  end
end