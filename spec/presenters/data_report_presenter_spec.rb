require "spec_helper"


describe DataReportPresenter do 

  let!(:report) { DataReport.create!(data_report_type_name: "all_supporters") }

  let!(:presenter) { DataReportPresenter.new(report) }

  describe '#initialize' do 
    it 'should create an object' do 
      expect(presenter).to be_an_instance_of DataReportPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of DataReport
    end
  end

  describe '#human_type_name' do 
    it 'should format the type name' do 
      expect(presenter.human_type_name).to eq report.data_report_type_name.humanize
    end
  end
end
