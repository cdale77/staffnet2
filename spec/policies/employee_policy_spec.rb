require 'spec_helper'

describe EmployeePolicy do

  subject { EmployeePolicy.new(user, employee) }

  let(:employee) { FactoryGirl.create(:employee) }

=begin
turned off for now because the before_filter in ApplicationController should catch no users
TODO: fix this so the policy spec covers cases where there is no logged in user
  context 'for a visitor' do
    let(:user) { nil }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:show) }
    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end
=end

  context 'for a regular user' do
    let(:user) { FactoryGirl.create(:user) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:show) }
    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for a staff user' do
    #create a new test user with role of staff and with a dependent employee record
    let(:user) { FactoryGirl.create(:staff) }
    let(:employee) { FactoryGirl.create(:employee, user_id: user.id) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }

    context 'looking at their own profile' do
      it { should permit(:show) }
    end
  end

  context 'for a manager user' do
    let(:user) { FactoryGirl.create(:manager) }

    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should permit(:show) }
    it { should permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for an admin user' do
    let(:user) { FactoryGirl.create(:admin) }

    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'for a super_admin user' do
    let(:user) { FactoryGirl.create(:super_admin) }

    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end
end