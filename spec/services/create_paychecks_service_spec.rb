require "spec_helper"

describe CreatePaycheckService do

  let!(:paycheck_service) { CreatePaycheckService.new }

  describe '#initialize' do
    it 'should create an object' do
      paycheck_service.should be_an_instance_of CreatePaycheckService
    end
  end

end