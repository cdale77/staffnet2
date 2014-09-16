require "spec_helper"
include ActionView::Helpers::NumberHelper

describe DonationPresenter do

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:shift) { FactoryGirl.create(:shift,
                                    employee: employee) }
  let!(:donation) { FactoryGirl.create(:donation,
                                       supporter: supporter,
                                       shift: shift) }
  let!(:payment) { FactoryGirl.create(:payment,
                                      donation: donation) }
  let!(:presenter) { DonationPresenter.new(donation) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of DonationPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of Donation
    end
  end

  describe '#supporter_full_name' do
    it 'should return the name of the supporter' do
      expect(presenter.supporter_full_name).to eq supporter.full_name
    end
  end

  describe '#formatted_date' do
    it 'should return the formatted date' do
      expect(presenter.formatted_date).to eq I18n.l(donation.date)
    end
  end

  describe '#formatted_amount' do
    it 'should format the amount' do
      expect(presenter.formatted_amount).to eq \
        number_to_currency(donation.amount)
    end
  end

  describe '#type_to_human' do
    it 'should return the humanized donation type' do
      expect(presenter.type_to_human).to eq donation.donation_type.humanize
    end
  end

  describe '#source_to_human' do
    it 'should return the humanized donation source' do
      expect(presenter.source_to_human).to eq donation.source.humanize
    end
  end

  describe '#campaign_to_human' do
    it 'should return the humanized campaign name' do
      expect(presenter.campaign_to_human).to eq donation.campaign.humanize
    end
  end

  describe '#cancelled_to_human' do
    it 'should return the yes or no' do
      expect(presenter.cancelled_to_human).to eq "No"
    end
  end

  describe '#captured_to_human' do
    it 'should return the yes or no' do
      expect(presenter.captured_to_human).to eq "Yes"
    end
  end

  describe '#frequency_to_human' do
    it 'should return the yes or no' do
      expect(presenter.frequency_to_human).to eq "One-time"
    end
  end
end
