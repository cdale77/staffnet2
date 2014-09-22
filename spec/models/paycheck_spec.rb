# == Schema Information
#
# Table name: paychecks
#
#  id                       :integer          not null, primary key
#  payroll_id               :integer
#  employee_id              :integer
#  check_date               :date
#  shift_quantity           :decimal(8, 2)    default("0.0")
#  cv_shift_quantity        :decimal(8, 2)    default("0.0")
#  quota_shift_quantity     :decimal(8, 2)    default("0.0")
#  office_shift_quantity    :decimal(8, 2)    default("0.0")
#  sick_shift_quantity      :decimal(8, 2)    default("0.0")
#  vacation_shift_quantity  :decimal(8, 2)    default("0.0")
#  holiday_shift_quantity   :decimal(8, 2)    default("0.0")
#  total_deposit            :decimal(8, 2)    default("0.0")
#  old_buffer               :decimal(8, 2)    default("0.0")
#  new_buffer               :decimal(8, 2)    default("0.0")
#  total_pay                :decimal(8, 2)    default("0.0")
#  bonus                    :decimal(8, 2)    default("0.0")
#  travel_reimb             :decimal(8, 2)    default("0.0")
#  created_at               :datetime
#  updated_at               :datetime
#  notes                    :text             default("")
#  gross_fundraising_credit :decimal(8, 2)    default("0.0")
#  credits                  :decimal(8, 2)    default("0.0")
#  docks                    :decimal(8, 2)    default("0.0")
#  total_quota              :decimal(8, 2)    default("0.0")
#  net_fundraising_credit   :decimal(8, 2)    default("0.0")
#  over_quota               :decimal(8, 2)    default("0.0")
#  temp_buffer              :decimal(8, 2)    default("0.0")
#  bonus_credit             :decimal(8, 2)    default("0.0")
#

require "spec_helper"

describe Paycheck do

  paycheck_attributes = SpecData.paycheck_attributes

  let!(:payroll) { FactoryGirl.create(:payroll) }
  let!(:paycheck) { FactoryGirl.create(:paycheck,
                                       employee: employee,
                                       payroll: payroll) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:shift_type) { FactoryGirl.create(:shift_type,
                                          name: "street",
                                          workers_comp_type: "outside",
                                          fundraising_shift: true) }
  let!(:shift_type2) { FactoryGirl.create(:shift_type,
                                         name: "phone",
                                         workers_comp_type: "inside",
                                         fundraising_shift: true) }
  let!(:shift) { FactoryGirl.create(:shift,
                                    paycheck: paycheck,
                                    employee: employee,
                                    shift_type: shift_type) }

  let!(:shift2) { FactoryGirl.create(:shift,
                                    paycheck: paycheck,
                                    employee: employee,
                                    shift_type: shift_type2) }
  let!(:donation) { FactoryGirl.create(:donation,
                                       amount: 10,
                                       donation_type: "cash",
                                       shift: shift) }
  let!(:donation2) { FactoryGirl.create(:donation,
                                        amount: 10,
                                        donation_type: "credit",
                                        sub_week: 1,
                                        sub_month: "m",
                                        shift: shift) }
  let!(:payment) { FactoryGirl.create(:payment,
                                      amount: 10,
                                      captured: true,
                                      donation: donation) }
  let!(:payment2) { FactoryGirl.create(:payment,
                                       amount: 10,
                                       captured: true,
                                       donation: donation2) }


  subject { paycheck }

  ## ATTRIBUTES
  describe 'attribute tests' do
    paycheck_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:employee) }
  it { should respond_to(:payroll) }
  it { should respond_to(:shifts) }

  ## DELEGATIONS
  it { should respond_to(:user) }

  ## METHODS
  describe 'inside outside splits' do
    it 'should provide the correct inside shift number' do
      expect(paycheck.inside_shift_count).to eq 1
      expect(paycheck.outside_shift_count).to eq 1
    end
  end

end
