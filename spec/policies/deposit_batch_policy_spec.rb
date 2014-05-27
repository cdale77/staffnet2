require 'spec_helper'

describe DepositBatchPolicy do
  subject { DepositBatchPolicyh.new(user, deposit_batch) }

  let(:deposit_batch) { DepositBatch.new }

  context 'for a regular user' do
    let(:user) { FactoryGirl.create(:user) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for a staff user' do
    let(:user) { FactoryGirl.create(:staff) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }

  end

  context 'for a manager user' do
    let(:user) { FactoryGirl.create(:manager) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for an admin user' do
    let(:user) { FactoryGirl.create(:admin) }

    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'for a super_admin user' do
    let(:user) { FactoryGirl.create(:super_admin) }

    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end
end