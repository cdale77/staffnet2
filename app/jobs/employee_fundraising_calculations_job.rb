require "active_job"

class EmployeeFundraisingCalculationsJob < ActiveJob::Base
  queue_as :default

  def perform
    Employee.active.each do |employee|
      employee.update_attributes(Employee.statistics(employee))
      employee.save
    end

  end
end

