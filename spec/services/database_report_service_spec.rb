require "spec_helper"

describe DatabaseReportService do

  let!(:service) { DatabaseReportService.new }

  describe '#initialize' do
    it 'should create an object' do
      expect(service).to be_an_instance_of DatabaseReportService
    end
  end

  describe '#perform' do
    it 'should return a StringIO' do
      expect(service.perform).to be_an_instance_of StringIO
    end
  end
end

