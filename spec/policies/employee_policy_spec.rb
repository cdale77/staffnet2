require 'spec_helper'
require 'pundit/rspec'

describe EmployeePolicy do

  subject { EmployeePolicy }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }

  permissions :create? do
    it 'allows super_admin and admin' do
      should permit(super_admin, Employee.new)
      should permit(admin, Employee.new)
    end
  end
end