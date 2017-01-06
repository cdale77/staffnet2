# == Schema Information
#
# Table name: deposit_batches
#
#  id             :integer          not null, primary key
#  employee_id    :integer
#  batch_type     :string(255)      default("")
#  date           :date
#  deposited      :boolean          default(FALSE)
#  approved       :boolean          default(FALSE)
#  receipt_number :string(255)      default("")
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :deposit_batch do
    date Date.today
    batch_type 'installment'
    employee
  end
end
