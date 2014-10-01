require "spec_helper"

describe CreateDuplicateRecordsService do 

  report_path = ""

  let!(:service) { CreateDuplicateRecordsService.new(report_path) }

  describe 'initialize' do
    it 'should create an object' do
      service.should be_an_instance_of CreateDuplicateRecordsService
    end
  end

end