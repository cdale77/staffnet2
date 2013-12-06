=begin
require 'spec_helper'

describe TaskPolicy do

  subject { TaskPolicy.new(user, task) }

  let(:task) { FactoryGirl.create(:task) }

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

    context 'for other employee tasks' do
      it { should_not permit(:new) }
      it { should_not permit(:create) }
      it { should_not permit(:show) }
      it { should_not permit(:index) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

    context 'for their own tasks' do
      let(:employee) { FactoryGirl.create(:employee, user_id: user.id) }
      let(:shift) { FactoryGirl.create(:shift, employee_id: employee.id) }
      let(:task) { FactoryGirl.create(:task, shift_id: shift.id) }

      it { should permit(:new) }
      it { should permit(:create) }
      it { should permit(:show) }
      it { should permit(:index) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
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
=end
