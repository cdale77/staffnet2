require 'spec_helper'
include Warden::Test::Helpers
include ActionView::Helpers::NumberHelper
Warden.test_mode!

describe 'PaycheckPages' do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:paycheck) { FactoryGirl.create(:paycheck,
                                       employee: employee) }
  let!(:shift1) { FactoryGirl.create(:shift,
                                      date: (Date.today - 4.years),
                                      paycheck: paycheck,
                                      employee: employee) }
  let!(:shift2) { FactoryGirl.create(:shift,
                                     date: (Date.today - 1.year),
                                     paycheck: paycheck,
                                     employee: employee) }

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
      describe 'page' do
        before { visit paycheck_path(paycheck) }
        describe 'page' do
          it { should have_content (employee.full_name) }
          it { should have_content (paycheck.check_date) }
          it { should have_content (number_to_currency(paycheck.total_pay)) }
        end
        describe 'shifts' do
          it { should have_content (shift1.date) }
          it { should have_content (shift2.date) }

        end
      end
    end

    describe 'edit' do 
      before { visit edit_paycheck_path(paycheck) }
      describe 'page' do 
        it { should have_title("Edit paycheck") }
        it { should have_selector("h1", "Edit donation") }
      end
    end
  end
end
