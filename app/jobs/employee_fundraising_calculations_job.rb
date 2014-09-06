require "active_job"

class EmployeeFundraisingCalculationsJob < ActiveJob::Base
  queue_as :default

  def perform
    Employee.active.each do |employee|
      results = calculate_values(employee)
      employee.assign_attributes(results)
      employee.save
    end

    def calculate_values(employee)
      shifts = employee.shifts
      shifts_this_week = shifts.where(date: (Date.today.beginning_of_week..Date.today))
      fundraising_shifts = shifts.select { |s| s.fundraising_shift }
      fundraising_shifts_this_week = shifts_this_week.select { |s| s.fundraising_shift }
      donations = employee.donations
      successful_donations = donations.select { |d| d.captured }
      donations_this_week = donations.select { |d| (Date.today.beginning_of_week..Date.today).include?(d.shift.date) }
      successful_donations_this_week = successful_donations.select { |d| (Date.today.beginning_of_week..Date.today).include?(d.shift.date) }
      {
          shifts: shifts.count,
          shifts_this_week: shifts_this_week.count,
          fundraising_shifts: fundraising_shifts.count,
          fundraising_shifts_this_week: fundraising_shifts_this_week.count,
          donations: donations.count,
          donations_this_week: donations_this_week.count,
          successful_donations: successful_donations.count,
          successful_donations_this_week:  successful_donations_this_week.count,
          raised_lifetime: successful_donations.sum(&:total_value),
          raised_this_week: successful_donations_this_week.sum(&:total_value),
          average_lifetime: calculate_average(raised_lifetime, fundraising_shifts.count),
          average_this_week: calculate_averge(raised_this_week / fundraising_shifts_this_week.count)
      }
    end

    def calculate_average(raised, shifts_count)
      if fundraising_shifts_count > 0
        raised / shifts_count
      else
        0
      end
    end
  end
end

