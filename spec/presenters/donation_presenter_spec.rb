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
end
