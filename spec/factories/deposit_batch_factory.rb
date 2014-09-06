# == Schema Information
#
# Table name: deposit_batches
#
#  id             :integer          not null, primary key
#  employee_id    :integer
#  batch_type     :string           default("")
#  date           :date
#  deposited      :boolean          default("false")
#  created_at     :datetime
#  updated_at     :datetime
#  approved       :boolean          default("false")
#  receipt_number :string           default("")
#

FactoryGirl.define do
  factory :deposit_batch do
    date Date.today
    batch_type 'installment'
  end
end
