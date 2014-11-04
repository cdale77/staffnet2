require "spec_helper"
include ActionView::Helpers::NumberHelper

describe PaycheckPresenter do

  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:paycheck) { FactoryGirl.create(:paycheck) }

  let!(:presenter) { PaycheckPresenter.new(paycheck) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of PaycheckPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of Paycheck
    end
  end

  describe '#check_date' do
    it 'should format the date' do
      expect(presenter.formatted_check_date).to eq I18n.l(paycheck.check_date)
    end
  end

  describe '#formatted_bonus' do
    it 'should format the bonus' do
      expect(presenter.formatted_bonus).to eq number_to_currency(paycheck.bonus)
    end
  end

  describe '#formatted_travel_reimb' do
    it 'should format the travel_reimb' do
      expect(presenter.formatted_travel_reimb).to eq \
        number_to_currency(paycheck.travel_reimb)
    end
  end

  describe '#formatted_total_pay' do
    it 'should format the total_pay' do
      expect(presenter.formatted_total_pay).to eq \
        number_to_currency(paycheck.total_pay)
    end
  end

  describe '#other_shift_quantity' do
    it 'should add up the vacation, holiday, and sick shifts' do
      expect(presenter.other_shift_quantity).to eq \
        paycheck.sick_shift_quantity + presenter.vacation_shift_quantity + \
        paycheck.holiday_shift_quantity
    end
  end

  describe '#formatted_gross_fundraising_credit' do
    it 'should format the amount' do
      expect(presenter.formatted_gross_fundraising_credit).to eq \
        number_to_currency(paycheck.gross_fundraising_credit)
    end
  end

  describe '#formatted_total_deposit' do
    it 'should format the amount' do
      expect(presenter.formatted_total_deposit).to eq \
        number_to_currency(paycheck.total_deposit)
    end
  end

  describe '#formatted_total_quota' do
    it 'should format the amount' do
      expect(presenter.formatted_total_quota).to eq \
        number_to_currency(paycheck.total_quota)
    end
  end

  describe '#formatted_total_credits' do
    it 'should format the amount' do
      expect(presenter.formatted_total_credits).to eq \
        number_to_currency(paycheck.credits)
    end
  end

  describe '#formatted_total_docks' do
    it 'should format the amount' do
      expect(presenter.formatted_total_docks).to eq \
        number_to_currency(paycheck.docks)
    end
  end

  describe '#formatted_net_fundraising_credit' do
    it 'should format the amount' do
      expect(presenter.formatted_net_fundraising_credit).to eq \
        number_to_currency(paycheck.net_fundraising_credit)
    end
  end

  describe '#formatted_new_buffer' do
    it 'should format the amount' do
      expect(presenter.formatted_new_buffer).to eq \
        number_to_currency(paycheck.new_buffer)
    end
  end

  describe '#formatted_old_buffer' do
    it 'should format the amount' do
      expect(presenter.formatted_old_buffer).to eq \
        number_to_currency(paycheck.old_buffer)
    end
  end

  describe '#formatted_over_quota' do
    it 'should format the amount' do
      expect(presenter.formatted_over_quota).to eq \
        number_to_currency(paycheck.over_quota)
    end
  end

  describe '#employee_full_name' do
    it 'should provide the name' do
      expect(presenter.employee_full_name).to eq paycheck.employee.full_name
    end
  end

  describe '#employee_last_name' do 
    it 'should provide the last name' do 
      expect(presenter.employee_last_name).to eq paycheck.employee.last_name
    end
  end
end

