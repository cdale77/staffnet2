require 'spec_helper'

describe PledgeEmailPolicy do

  subject { PledgeEmailPolicy.new(user, pledge_email) }
  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let(:pledge_email) { PledgeEmail.new(supporter, employee) }

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

    it { should permit(:new) }
    it { should permit(:create) }
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