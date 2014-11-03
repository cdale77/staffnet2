require "spec_helper"

describe PaycheckPolicy do

  subject { PaycheckPolicy.new(user, paycheck) }

  let(:employee) { FactoryGirl.create(:employee) }
  let(:paycheck) { FactoryGirl.create(:paycheck) }

  context 'for a regular user' do
    let(:user) { FactoryGirl.create(:user) }

    it { should_not permit(:show) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
  end

  context 'for a staff user' do
    let(:user) { FactoryGirl.create(:staff) }

    context 'for other employee shifts' do
      it { should_not permit(:show) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
    end

    context 'for their own shifts' do
      let(:employee) { FactoryGirl.create(:employee, user: user) }
      let(:paycheck) { FactoryGirl.create(:paycheck, employee: employee) }

      it { should permit(:show) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
    end
  end

  context 'for a manager user' do
    let(:user) { FactoryGirl.create(:staff) }

    context 'for other employee shifts' do
      it { should_not permit(:show) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
    end

    context 'for their own shifts' do
      let(:employee) { FactoryGirl.create(:employee, user: user) }
      let(:paycheck) { FactoryGirl.create(:paycheck, employee: employee) }

      it { should permit(:show) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
    end
  end

  context 'for an admin user' do
    let(:user) { FactoryGirl.create(:admin) }

    it { should permit(:show) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
  end

  context 'for a super_admin user' do
    let(:user) { FactoryGirl.create(:super_admin) }

    it { should permit(:show) }
    it { should permit(:edit) }
    it { should permit(:update) }
  end
end
