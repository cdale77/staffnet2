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

class Payroll < ActiveRecord::Base

  has_paper_trail

  default_scope { order(end_date: :desc) }

  ## RELATIONSHIPS
  has_many :paychecks

  ## ATTACHMENTS
=begin
  has_attached_file :paycheck_report,
              s3_headers:   { "Content-Type" => "text/plain" },
              path: ":rails_root/public/system/:class/:attachment/:filename",
              s3_permissions: :private

  has_attached_file :shift_report,
              s3_headers:   { "Content-Type" => "text/plain" },
              path: ":rails_root/public/system/:class/:attachment/:filename",
              s3_permissions: :private

  validates_attachment :paycheck_report,
         content_type: { content_type: /\Atext/ }

  validates_attachment :shift_report,
         content_type: { content_type: /\Atext/ }
=end



  def set_start_and_end_dates
    last_payroll = Payroll.first
    if last_payroll
      new_start_date = last_payroll.end_date + 1.day
      new_end_date = last_payroll.end_date + 14.days
      self.start_date = new_start_date
      self.end_date = new_end_date
    end
  end

  ## METHODS

  def non_cv_shift_quantity
    office_shift_quantity + sick_shift_quantity + vacation_shift_quantity
  end
end
