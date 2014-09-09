require "spec_helper"

describe CalculatePaycheckService do

  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:shift) { FactoryGirl.create(:shift,
                                    employee: employee,
                                    paycheck: paycheck) }
  let!(:payroll) { Payroll.create }
  let!(:paycheck) { Paycheck.create(employee_id: employee.id,
                                    payroll_id: payroll.id) }

  let!(:calculations_service) { CalculatePaycheckService.new(paycheck) }

  describe '#initialize' do
    it 'should create an object' do
      calculations_service.should be_an_instance_of CalculatePaycheckService
    end
  end

end