require 'spec_helper'
#require 'pundit/rspec'

describe EmployeePolicy do

  subject { EmployeePolicy.new(user, employee) }

  let(:employee) { FactoryGirl.create(:employee) }

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
    let(:user) { FactoryGirl.create(:staff, employee_id: employee.id) }

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

=begin
  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }

  permissions :new? do
    it 'allows super_admin and admin' do
      should permit(super_admin, Employee.new)
      should permit(admin, Employee.new)
    end

    it 'does not allow manager, staff, or user' do
      should_not permit(manager, Employee.new)
      should_not permit(staff, Employee.new)
      should_not permit(user, Employee.new)
    end
  end

  permissions :create? do
    it 'allows super_admin and admin' do
      should permit(super_admin, Employee.create)
      should permit(admin, Employee.create)
    end

    it 'does not allow manager, staff, or user' do
      should_not permit(manager, Employee.create)
      should_not permit(staff, Employee.create)
      should_not permit(user, Employee.create)
    end
  end

  permissions :show? do
    it 'allows super_admin and admin' do
      should permit(super_admin, Employee.create)
      should permit(admin, Employee.create)
    end

    it 'does not allow manager, staff, or user' do
      should_not permit(manager, Employee.create)
      should_not permit(staff, Employee.create)
      should_not permit(user, Employee.create)
    end
  end

  permissions :create? do
    it 'allows super_admin and admin' do
      should permit(super_admin, Employee.create)
      should permit(admin, Employee.create)
    end

    it 'does not allow manager, staff, or user' do
      should_not permit(manager, Employee.create)
      should_not permit(staff, Employee.create)
      should_not permit(user, Employee.create)
    end
=end

end