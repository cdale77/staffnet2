# == Schema Information
#
# Table name: supporter_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("")
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :supporter_type do
    name        'supporter'
  end
end
