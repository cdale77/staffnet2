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
  let!(:payment_profile) { FactoryGirl.create(:payment_profile) }
  let!(:payment) { FactoryGirl.create(:payment,
                                      payment_profile: payment_profile,
                                      donation: donation,
                                      deposited_at: Date.today) }
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
      status = payment.captured ? "Captured" : "Declined"
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
      expect(presenter.source_to_human).to eq payment.donation.source.humanize

    end
  end

  describe '#formatted_donation_amount' do
    it 'should return the formatted donation amount' do
      expect(presenter.formatted_donation_amount).to eq \
        number_to_currency(donation.amount)
    end
  end

  describe '#payment_status' do
    it 'should return the status of the payment' do
      expect(presenter.payment_status).to eq "Processed"
    end
  end

  describe '#formatted_receipt_sent_at' do
    it 'should format the receipt sent at' do
      expect(presenter.formatted_receipt_sent_at).to eq \
        I18n.l(payment.receipt_sent_at, format: :long)
    end
  end

  describe '#formatted_donation_date' do
    it 'should format the donation date' do
      expect(presenter.formatted_donation_date).to eq \
        I18n.l(donation.date)
    end
  end

  describe '#is_donation_sustainer?' do
    it 'should return false if the donation is not sustainer' do
      expect(presenter.is_donation_sustainer?).to eq false
    end
  end

  describe '#donation_sub_month' do
    it 'should return the sub_month code of the donation' do
      expect(presenter.donation_sub_month).to eq donation.sub_month
    end
  end

  describe '#donation_sub_week' do
    it 'should return the sub_week code of the donation' do
      expect(presenter.donation_sub_week).to eq donation.sub_week
    end
  end

  describe '#payment_profile_short' do
    it 'should return a short version of the payment profile details' do
      expect(presenter.payment_profile_short).to eq \
        payment_profile.short_version
    end
  end

  describe '#cim_payment_profile_id' do
    it 'should return the profile cim id' do
      expect(presenter.cim_payment_profile_id).to eq \
        payment_profile.cim_payment_profile_id
    end
  end

  describe '#formatted_deposited_at' do
    it 'should format the deposit date' do
      expect(presenter.formatted_deposited_at).to eq \
        I18n.l(payment.deposited_at)
    end
  end
end
