require 'spec_helper'

describe PayrollPolicy do

  subject { PayrollPolicy.new(user, payroll) }

  let(:payroll) { FactoryGirl.build(:payroll) }

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

    it { should_not permit(:show) }
    it { should_not permit(:index) }
  end

  context 'for a staff user' do
    let(:user) { FactoryGirl.create(:staff) }

    it { should_not permit(:show) }
    it { should_not permit(:index) }
  end

  context 'for a manager user' do
    let(:user) { FactoryGirl.create(:manager) }

    it { should_not permit(:show) }
    it { should_not permit(:index) }
  end

  context 'for an admin user' do
    let(:user) { FactoryGirl.create(:admin) }

    it { should permit(:show) }
    it { should permit(:index) }
  end

  context 'for a super_admin user' do
    let(:user) { FactoryGirl.create(:super_admin) }

    it { should permit(:show) }
    it { should permit(:index) }
  end
end
