# == Schema Information
#
# Table name: paychecks
#
#  id                       :integer          not null, primary key
#  payroll_id               :integer
#  employee_id              :integer
#  check_date               :date
#  shift_quantity           :decimal(8, 2)    default(0.0)
#  cv_shift_quantity        :decimal(8, 2)    default(0.0)
#  quota_shift_quantity     :decimal(8, 2)    default(0.0)
#  office_shift_quantity    :decimal(8, 2)    default(0.0)
#  sick_shift_quantity      :decimal(8, 2)    default(0.0)
#  vacation_shift_quantity  :decimal(8, 2)    default(0.0)
#  holiday_shift_quantity   :decimal(8, 2)    default(0.0)
#  total_deposit            :decimal(8, 2)    default(0.0)
#  total_fundraising_credit :decimal(8, 2)    default(0.0)
#  old_buffer               :decimal(8, 2)    default(0.0)
#  new_buffer               :decimal(8, 2)    default(0.0)
#  total_pay                :decimal(8, 2)    default(0.0)
#  bonus                    :decimal(8, 2)    default(0.0)
#  travel_reimb             :decimal(8, 2)    default(0.0)
#  created_at               :datetime
#  updated_at               :datetime
#

require "spec_helper"

describe Paycheck do

  paycheck_attributes = {
      check_date: Date.today,
      shift_quantity: 80,
      cv_shift_quantity: 74,
      quota_shift_quantity: 80,
      office_shift_quantity: 16,
      sick_shift_quantity: 0,
      vacation_shift_quantity: 0,
      holiday_shift_quantity: 0,
      total_deposit: 9876,
      total_fundraising_credit: 10764
  }

  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:shift) { FactoryGirl.create(:shift, employee: employee) }
  let!(:paycheck) { FactoryGirl.create(:paycheck) }

  subject { paycheck }

  ## ATTRIBUTES
  describe 'payroll attribute tests' do
    paycheck_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:employee) }
  it { should respond_to(:payroll) }
  it { should respond_to(:shifts) }
end
