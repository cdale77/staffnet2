require "spec_helper"

describe DonationHistoryReportService do 

  let!(:service) { DonationHistoryReportService.new }

  describe '#initialize' do
    it 'should create an object' do
      expect(service).to be_an_instance_of DonationHistoryReportService
    end
  end

  describe '#perform' do
    it 'should return a string' do
      expect(service.perform).to be_an_instance_of String
    end
  end

end
