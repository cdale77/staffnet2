require "spec_helper"
include Warden::Test::Helpers
include ActionView::Helpers::NumberHelper
Warden.test_mode!

describe 'PayrollPages' do 

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:employee2) { FactoryGirl.create(:employee, 
                                        first_name: "Jon") }
  let!(:payroll) { FactoryGirl.create(:payroll, 
                                      end_date: Date.today) }
  let!(:payroll2) { FactoryGirl.create(:payroll, 
                                        end_date: (Date.today - 2.weeks)) }
  let!(:paycheck) { FactoryGirl.create(:paycheck,
                                       employee: employee,
                                       payroll: payroll) }
  let!(:paycheck2) { FactoryGirl.create(:paycheck,
                                       employee: employee2,
                                       payroll: payroll,
                                       check_date: Date.today) }

  #### AS SUPERADMIN USER ####

  # log in as superadmin user to test basic functionality of the pages.
  # Authorization is handled in the  policy specs
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
      before { visit payroll_path(payroll) }
      describe 'page' do 
        it { should have_title("Staffnet:Payroll") }
        it { should have_content("Payroll") }
        it { should have_content(payroll.end_date) }
        it { should have_content(payroll.start_date) }
      end
      describe 'paychecks' do 
        it { should have_content(employee.full_name) }
        it { should have_content(employee2.full_name) }
        it { should have_content(paycheck.check_date) }
        it { should have_content(paycheck2.check_date) }
      end

    end
    
    describe 'index' do 
      before { visit payrolls_path }
      describe 'page' do 
        it { should have_title("Staffnet:Payrolls") }
      end
      describe 'listing' do 
        it { should have_content(payroll.end_date) }
        it { should have_content(payroll2.end_date) }
      end
    end
  end
end



