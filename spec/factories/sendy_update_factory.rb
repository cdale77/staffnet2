# == Schema Information
#
# Table name: sendy_updates
#
#  id               :integer          not null, primary key
#  supporter_id     :integer
#  sendy_list_id    :integer
#  sendy_batch_id   :integer
#  sendy_email      :string(255)      default("")
#  new_sendy_email  :string(255)      default("")
#  new_sendy_status :string(255)      default("")
#  action           :string(255)      default("")
#  success          :boolean          default("false")
#  completed_at     :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :sendy_update do
    sendy_email     'example@example.com'
    new_sendy_email 'new_example@example.com'
    new_sendy_status  'subscribed'
    action          'subscribe'
    success         true
  end
end
