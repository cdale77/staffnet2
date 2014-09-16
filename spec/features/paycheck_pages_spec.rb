require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'PaycheckPages' do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:paycheck) { FactoryGirl.create(:paycheck,
                                       employee: employee) }

  #### AS SUPERADMIN USER ####

  # log in as superadmin user to test basic functionality of the pages.
  # Authorization is handled in the  policy specs
=begin
  describe 'as super_admin user' do

    before do
      visit new_user_session_path
      fill_in 'Email',    with: super_admin.email
      fill_in 'Password', with: super_admin.password
      click_button 'Sign in'
    end

    after do
      logout(:super_admin)
    end

    describe 'show' do
      describe 'page' do
        before { visit employee_paycheck_path(employee, paycheck) }
        describe 'page' do
          it { should have_content (employee.first_name) }
          it { should have_content (employee.last_name) }
          it { should have_content (paycheck.check_date) }
        end
      end
    end
  end
=end
end
