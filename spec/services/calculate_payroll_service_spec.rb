require "spec_helper"

describe CalculatePayrollService do

  let!(:payroll) { FactoryGirl.create(:payroll) }
  let!(:service) { CalculatePayrollService.new(payroll: payroll) }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of CalculatePayrollService
    end
  end
end

