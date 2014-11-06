require "spec_helper"


describe ExportTemplate::Excel::Workbook do

  let!(:template) { ExportTemplate::Excel::Workbook.new }

  describe '#initialize' do
    it 'should create an object' do
      expect(template).to be_an_instance_of ExportTemplate::Excel::Workbook
    end
  end

  describe '#header' do
    it 'should be a string' do
      expect(template.header).to be_an_instance_of String
    end
  end

  describe '#footer' do
    it 'should be a string' do
      expect(template.footer).to be_an_instance_of String
    end
  end
end
