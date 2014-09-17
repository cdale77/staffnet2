require "spec_helper"
include ActionView::Helpers::NumberHelper

describe ShiftPresenter do

  let!(:shift_type) { FactoryGirl.create(:shift_type) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:shift) { FactoryGirl.create(:shift,
                                     employee: employee,
                                     shift_type: shift_type,
                                     field_manager_employee_id: employee.id) }

  let!(:presenter) { ShiftPresenter.new(shift) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of ShiftPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of Shift
    end
  end

  describe '#employee_name' do
    it 'should return the name of the employee' do
      expect(presenter.employee_name).to eq employee.full_name
    end
  end

  describe '#field_manager_name' do
    it 'should return the name of the field_manager' do
      expect(presenter.field_manager_name).to eq employee.full_name
    end
  end

  describe '#shift_type_name' do
    it 'should humanize the shift type name' do
      expect(presenter.shift_type_name).to eq shift_type.name.humanize
    end
  end

  describe '#site_to_human' do
    it 'should humanize the site name' do
      expect(presenter.site_to_human).to eq shift.site.humanize
    end
  end

  describe '#formatted_travel_reimb' do
    it 'should format the travel reimb for currency' do
      expect(presenter.formatted_travel_reimb). to eq \
        number_to_currency(shift.travel_reimb)
    end
  end

  describe '#formatted_time_in' do
    it 'should format the formatted time' do
      expect(presenter.formatted_time_in). to eq \
        I18n.l(shift.time_in, format: :short)
    end
  end

  describe '#formatted_time_out' do
    it 'should format the formatted time' do
      expect(presenter.formatted_time_out). to eq \
      I18n.l(shift.time_out, format: :short)
    end
  end

  describe '#formatted_reported_raised' do
    it 'should format the amount' do
      expect(presenter.formatted_reported_raised). to eq \
        number_to_currency(shift.reported_raised)
    end
  end

  describe '#formatted_gross_fundraising_credit' do
    it 'should format the amount' do
      expect(presenter.formatted_gross_fundraising_credit). to eq \
        number_to_currency(shift.gross_fundraising_credit)
    end
  end

  describe '#formatted_total_deposit' do
    it 'should format the amount' do
      expect(presenter.formatted_total_deposit). to eq \
        number_to_currency(shift.total_deposit)
    end
  end
end