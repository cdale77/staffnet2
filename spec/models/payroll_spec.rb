# == Schema Information
#
# Table name: payrolls
#
#  id                           :integer          not null, primary key
#  start_date                   :date
#  end_date                     :date
#  check_quantity               :integer          default("0")
#  shift_quantity               :decimal(8, 2)    default("0.0")
#  cv_shift_quantity            :decimal(8, 2)    default("0.0")
#  quota_shift_quantity         :decimal(8, 2)    default("0.0")
#  office_shift_quantity        :decimal(8, 2)    default("0.0")
#  sick_shift_quantity          :decimal(8, 2)    default("0.0")
#  holiday_shift_quantity       :decimal(8, 2)    default("0.0")
#  total_deposit                :decimal(8, 2)    default("0.0")
#  created_at                   :datetime
#  updated_at                   :datetime
#  vacation_shift_quantity      :decimal(8, 2)    default("0.0")
#  notes                        :text             default("")
#  gross_fundraising_credit     :decimal(8, 2)    default("0.0")
#  net_fundraising_credit       :decimal(8, 2)    default("0.0")
#  paycheck_report_file_name    :string
#  paycheck_report_content_type :string
#  paycheck_report_file_size    :integer
#  paycheck_report_updated_at   :datetime
#  shift_report_file_name       :string
#  shift_report_content_type    :string
#  shift_report_file_size       :integer
#  shift_report_updated_at      :datetime
#

require "spec_helper"

describe Payroll do

  payroll_attributes = SpecData.payroll_attributes

  let!(:payroll) { FactoryGirl.build(:payroll) }

  subject { payroll }

  ## ATTRIBUTES
  describe 'payroll attribute tests' do
    payroll_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:paychecks) }

  ## METHODS
  describe '#non_cv_shift_quantity' do 
    it 'should return the non-cv shift count' do 
      non_cv_shift_count = payroll.office_shift_quantity + payroll.sick_shift_quantity + payroll.vacation_shift_quantity
      expect(payroll.non_cv_shift_quantity).to eq non_cv_shift_count
    end
  end
end
