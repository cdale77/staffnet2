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

class Payroll < ActiveRecord::Base

  has_paper_trail

  default_scope { order(end_date: :desc) }

  ## CALLBACKS

  before_save :set_start_and_end_dates



  private
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
