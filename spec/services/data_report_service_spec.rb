require "spec_helper"

describe DataReportService do 

  let!(:data_report) { DataReport.new(data_report_type_name: "all_supporters") }
  let!(:service) { DataReportService.new(data_report) }

  describe '#initialize' do 
    it 'should create an object' do 
      expect(service).to be_an_instance_of DataReportService
    end
  end

  describe '#perform' do 
    before { service.perform }
    it 'should attach a file' do 
      expect(data_report.downloadable_file_file_name).to_not be_blank
    end
  end
end