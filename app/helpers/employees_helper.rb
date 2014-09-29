module EmployeesHelper 

  def cache_key_for_employees
    count          = Employee.count
    max_updated_at = Employee.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "employees/all-#{count}-#{max_updated_at}"
  end
end
