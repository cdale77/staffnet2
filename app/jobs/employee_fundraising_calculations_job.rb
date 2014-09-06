require "active_job"

class EmployeeFundraisingCalculationsJob < ActiveJob::Base
  queue_as :default

  def perform
    Employee.active.each do |employee|
      shifts = employee.shifts
      shifts_this_week = shifts.where(date: (Date.today.beginning_of_week..Date.today))
      fundraising_shifts = shifts.select { |s| s.fundraising_shift }
      fundraising_shifts_this_week = shifts_this_week.select { |s| s.fundraising_shift }
      donations = Employee.donations
      donations_this_week = donations.select { |d| (Date.today.beginning_of_week..Date.today).include?(d.shift.date) }
      successful_donations = donations.select { |d| d.captured }
      successful_donations_this_week =  donations.select { |d| (Date.today.beginning_of_week..Date.today).include?(d.shift.date) }
      raised_lifetime = successful_donations.sum(&:total_value)
      raised_this_week = successful_donations_this_week.sum(&:total_value)
      average_lifetime = raised_lifetime / fundraising_shifts
      average_this_week = raised_this_week / fundraising_shifts_this_week

      employee.shifts_lifetime = shifts.count
      employee.shifts_this_week = shifts_this_week.count
      employee.fundraising_shifts_lifetime = fundraising_shifts.count
      employee.fundraising_shifts_this_week = fundraising_shifts_this_week.count
      employee.donations_lifetime = donations.count
      employee.donations_this_week = donations_this_week.count
      employee.successful_donations_lifetime = succesful_donations.count
      employee.successful_donations_this_week = successful_donations_this_week.count
      employee.raised_lifetime = raised_lifetime
      employee.raised_this_week = raised_this_week
      employee.average_lifetime = average_lifetime
      employee.average_this_week = average_this_week

      employee.save
    end
  end
end

