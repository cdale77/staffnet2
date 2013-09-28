require 'spec_helper'

describe ShiftPolicy do

  subject { ShiftPolicy.new(user, shift) }
  let(:employee) { FactoryGirl.create(:employee) }
  let(:shift) { FactoryGirl.create(:shift) }

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
    let(:user) { FactoryGirl.create(:staff) }

    context 'for other employee shifts' do
    #  it { should_not permit(:new) }
      it { should_not permit(:create) }
      it { should_not permit(:show) }
      it { should_not permit(:index) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

    context 'for their own shifts' do
      # ownership is set through the user-employee relationship. To test for when the user owns the shift, set the
      # user's employee id to the employee's id.

      let(:user) { FactoryGirl.create(:staff, employee_id: employee.id) }

      it { should permit(:new) }
      it { should permit(:create) }
      it { should permit(:show) }
      it { should permit(:index) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end
  end

  context 'for a manager user' do
    let(:user) { FactoryGirl.create(:manager) }

    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
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