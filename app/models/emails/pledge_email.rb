class PledgeEmail
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :pledge_amount, :due_date, :supporter, :employee

  def initialize(supporter, employee, attributes = {})
    @supporter = supporter
    @employee = employee
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end