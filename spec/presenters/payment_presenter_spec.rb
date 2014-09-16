require "spec_helper"
include ActionView::Helpers::NumberHelper

describe PaymentPresenter do

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:shift) { FactoryGirl.create(:shift,
                                    employee: employee) }
  let!(:donation) { FactoryGirl.create(:donation,
                                       supporter: supporter,
                                       shift: shift) }
  let!(:payment) { FactoryGirl.create(:payment,
                                       donation: donation) }
  let!(:presenter) { PaymentPresenter.new(payment) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of PaymentPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of Payment
    end
  end

  describe '#credited_employee' do
    it 'should return the name of the credited employee' do
      expect(presenter.credited_employee).to eq employee.full_name
    end
  end

  describe '#shift_date' do
    it 'should return the date of the associated shift' do
      expect(presenter.shift_date).to eq I18n.l(shift.date)
    end
  end

  describe '#supporter_name' do
    it 'should return the name of the supporter' do
      expect(presenter.supporter_name).to eq supporter.full_name
    end
  end

  describe '#captured_to_human' do
    it 'should return yes or no' do
      status = payment.captured ? "Yes" : "No"
      expect(presenter.captured_to_human).to eq status
    end
  end

  describe '#formatted_amount' do
    it 'should format the amount' do
      expect(presenter.formatted_amount).to eq \
        number_to_currency(payment.amount)
    end
  end

  describe '#type_to_human' do
    it 'should format the type' do
      expect(presenter.type_to_human).to eq payment.payment_type.humanize
    end
  end

  describe '#frequency_to_human' do
    it 'should format the frequency' do
      expect(presenter.frequency_to_human).to eq \
        payment.donation.frequency.humanize
    end
  end

  describe '#source_to_human' do
    it 'should format the frequency' do
      expect(presenter.source_to_human).to eq \
      payment.donation.source.humanize
    end
  end
end