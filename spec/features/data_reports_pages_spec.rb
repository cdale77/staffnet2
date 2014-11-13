require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'DataReportsPages' do 

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }

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

    describe 'new' do 
      before { visit new_data_report_path }
      describe 'page' do 
        it { should have_title("Staffnet:New data report") }
        it { should have_content("New data report")}
      end
      describe 'with valid information' do 
        before do
          select "Donation history", from: "Data report type name"
        end
        it 'should create a new data report' do 
          expect { click_button 'Create Data report'}.to change(DataReport, :count).by(1)
        end
      end
    end
  end
end

