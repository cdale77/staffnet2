require "spec_helper"

describe ExportTemplate::Excel::Worksheet do

  let!(:template) { ExportTemplate::Excel::Worksheet.new }

  describe '#initialize' do
    it 'should create an object' do
      expect(template).to be_an_instance_of ExportTemplate::Excel::Worksheet
    end
  end

  describe '#worksheet' do 
    it 'should return a string' do 
      expect(template.worksheet).to be_an_instance_of String
    end
  end
end
