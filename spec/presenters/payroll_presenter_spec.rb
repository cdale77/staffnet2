require "spec_helper"
include ActionView::Helpers::NumberHelper

describe PayrollPresenter do 

  let!(:payroll) { FactoryGirl.build(:payroll) }

  let!(:presenter) { PayrollPresenter.new(payroll) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of PayrollPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of Payroll
    end
  end

  describe '#formatted_end_date' do
    it 'should format the date' do
      expect(presenter.formatted_end_date).to eq I18n.l(payroll.end_date)
    end
  end

  describe '#formatted_raised' do
    it 'should format the amount' do
      expect(presenter.formatted_raised).to eq \
        number_to_currency(payroll.gross_fundraising_credit)
    end
  end

  describe '#formatted_total_deposit' do
    it 'should format the amount' do
      expect(presenter.formatted_total_deposit).to eq \
        number_to_currency(payroll.total_deposit)
    end
  end
end
