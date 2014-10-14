require "spec_helper"

describe CreateDuplicateRecordsService do 

  report_path = ""

  let!(:service) { CreateDuplicateRecordsService.new(file_path: report_path) }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of CreateDuplicateRecordsService
    end
  end

  describe '#create_database_records' do 
    it 'should create database records' do 
      sample_data = SpecData.duplicate_record_input_array
      expect { service.send(:create_database_records, sample_data) }.to \
        change(DuplicateRecord, :count).by(1)   
      record = DuplicateRecord.first
      expect(record.first_record_id).to eq 12345
      expect(record.additional_record_ids).to eq ["12346", "12347"]
    end
  end
end
