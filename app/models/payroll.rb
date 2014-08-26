# == Schema Information
#
# Table name: payrolls
#
#  id                       :integer          not null, primary key
#  start_date               :date
#  end_date                 :date
#  check_quantity           :integer          default(0)
#  shift_quantity           :decimal(8, 2)    default(0.0)
#  cv_shift_quantity        :decimal(8, 2)    default(0.0)
#  quota_shift_quantity     :decimal(8, 2)    default(0.0)
#  office_shift_quantity    :decimal(8, 2)    default(0.0)
#  sick_shift_quantity      :decimal(8, 2)    default(0.0)
#  holiday_shift_quantity   :decimal(8, 2)    default(0.0)
#  total_deposit            :decimal(8, 2)    default(0.0)
#  total_fundraising_credit :decimal(8, 2)    default(0.0)
#  created_at               :datetime
#  updated_at               :datetime
#  vacation_shift_quantity  :decimal(8, 2)    default(0.0)
#

class Payroll < ActiveRecord::Base

  has_paper_trail

  default_scope { order(end_date: :desc) }

  ## RELATIONSHIPS
  has_many :paychecks


  def create_paychecks
    check_date = self.end_date + 6.days
    payroll_shifts = Shift.where(date: self.start_date..self.end_date)
    shift_groups = payroll_shifts.group_by { |shift| shift.employee_id }

    # loop through the grouped shifts and create a check for each employee
    shift_groups.each do |shift_group|
      employee_id = shift_group.first
      paycheck = Paycheck.create(payroll_id: self.id,
                                employee_id: employee_id,
                                check_date: check_date)
      shifts = shift_group.second
      shifts.each do |shift|
        shift.paycheck_id = paycheck.id
        shift.save
      end

      #when everything is set up, calculate the paycheck values and save
      paycheck.calculate_values
      paycheck.save
    end
  end

  def set_start_and_end_dates
    last_payroll = Payroll.first
    if last_payroll
      new_start_date = last_payroll.end_date + 1.day
      new_end_date = last_payroll.end_date + 14.days
      self.start_date = new_start_date
      self.end_date = new_end_date
    end
  end

end
