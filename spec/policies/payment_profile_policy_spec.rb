require 'spec_helper'

describe PaymentProfilePolicy do

  subject { PaymentProfilePolicy.new(user, payment_profile) }

  let(:payment_profile) { FactoryGirl.create(:payment_profile) }

  context 'for a regular user' do
    let(:user) { FactoryGirl.create(:user) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
  end

  context 'for a staff user' do
    let(:user) { FactoryGirl.create(:staff) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
  end

  context 'for a manager user' do
    let(:user) { FactoryGirl.create(:manager) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
  end

  context 'for an admin user' do
    let(:user) { FactoryGirl.create(:admin) }

    it { should permit(:new) }
    it { should permit(:create) }
  end

  context 'for a super_admin user' do
    let(:user) { FactoryGirl.create(:super_admin) }

    it { should permit(:new) }
    it { should permit(:create) }
  end
end