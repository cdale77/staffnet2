require "spec_helper"

describe ResolveDuplicateRecordsSerive do 

  let!(:payload) { SpecData.resolve_dupe_payload }
  let!(:service) { ResolveDupicateRecordsService.new(payload) }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of ResolveDupicateRecordsService
    end
  end
end