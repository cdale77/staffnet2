require "spec_helper"


describe ExportTemplate::Excel::Workbook do

  let!(:template) { ExportTemplate::Excel::Workbook.new }

  describe '#initialize' do
    it 'should create an object' do
      expect(template).to be_an_instance_of ExportTemplate::Excel::Workbook
    end
  end

  describe '#export_file' do
    it 'should be a string' do
      expect(template.export_file).to be_an_instance_of String
    end
  end
end
