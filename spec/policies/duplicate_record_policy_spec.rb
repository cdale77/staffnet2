require "spec_helper"

describe DuplicateRecordPolicy do

  let(:duplicate_record) { DuplicateRecord.new }
  subject { DuplicateRecordPolicy.new(user, duplicate_record) }

  context 'for a regular user' do
    let(:user) { FactoryGirl.create(:user) }

    it { should_not permit(:new_batch) }
    it { should_not permit(:new_file) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for a staff user' do
    let(:user) { FactoryGirl.create(:staff) }

    it { should_not permit(:new_batch) }
    it { should_not permit(:new_file) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }

  end

    context 'for a manager user' do
    let(:user) { FactoryGirl.create(:manager) }

    it { should_not permit(:new_batch) }
    it { should_not permit(:new_file) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

    context 'for an admin user' do
    let(:user) { FactoryGirl.create(:admin) }

    it { should permit(:new_batch) }
    it { should permit(:new_file) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }

  end

    context 'for a super_admin user' do
    let(:user) { FactoryGirl.create(:super_admin) }

    it { should permit(:new_batch) }
    it { should permit(:new_file) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end
end

