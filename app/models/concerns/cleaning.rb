module Cleaning
  extend ActiveSupport::Concern

  def clean_phone(phone)
    phone.gsub(/[^0-9]/, "")[0..10]
  end
end