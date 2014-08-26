# == Schema Information
#
# Table name: payrolls
#
#  id                       :integer          not null, primary key
#  start_date               :date
#  end_date                 :date
#  check_quantity           :integer          default(0)
#  shift_quantity           :integer          default(0)
#  cv_shift_quantity        :integer          default(0)
#  quota_shift_quantity     :integer          default(0)
#  office_shift_quantity    :integer          default(0)
#  sick_shift_quantity      :integer          default(0)
#  vacation_shift_quantity  :integer          default(0)
#  total_deposit            :decimal(8, 2)    default(0.0)
#  total_fundraising_credit :decimal(8, 2)    default(0.0)
#  created_at               :datetime
#  updated_at               :datetime
#  holiday_shift_quantity   :integer          default(0)
#

require "spec_helper"

describe Payroll do

  payroll_attributes = {
      start_date: (Date.today - 2.weeks),
      end_date: Date.today,
      check_quantity: 8,
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

  let!(:payroll) { FactoryGirl.create(:payroll) }

  subject { payroll }

  ## ATTRIBUTES
  describe 'payroll attribute tests' do
    payroll_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  #it { should respond_to(:paychecks) }

end
