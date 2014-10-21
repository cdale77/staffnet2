require "spec_helper"

describe CreatePayrollService do

  let!(:payroll_service) { CreatePayrollService.new }

  describe '#initialize' do
    it 'should create an object' do
      payroll_service.should be_an_instance_of CreatePayrollService
    end
  end
end
