# == Schema Information
#
# Table name: sendy_lists
#
#  id                    :integer          not null, primary key
#  supporter_type_id     :integer
#  sendy_list_identifier :string(255)      default("")
#  name                  :string(255)      default("")
#  created_at            :datetime
#  updated_at            :datetime
#

FactoryGirl.define do
  factory :sendy_list do
    name      'supporters'
    sendy_list_identifier '23413rq3t985'
  end
end
