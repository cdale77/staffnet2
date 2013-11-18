# == Schema Information
#
# Table name: clients
#
#  id            :integer          not null, primary key
#  name          :string(255)      default("")
#  address1      :string(255)      default("")
#  address2      :string(255)      default("")
#  city          :string(255)      default("")
#  state         :string(255)      default("")
#  zip           :string(255)      default("")
#  contact_name  :string(255)      default("")
#  contact_phone :string(255)      default("")
#  contact_email :string(255)      default("")
#  uri           :string(255)      default("")
#  notes         :text             default("")
#

class Client < ActiveRecord::Base

  ## SET UP ENVIRONMENT
  include Regex
  
end
