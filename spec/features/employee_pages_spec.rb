require 'spec_helper'

describe 'EmployeePages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }

  let(:employee) { FactoryGirl.create(:employee) }

  ### HELPERS ###
  def fill_in_example_employee
    fill_in 'First name',             with: 'Brad'
    fill_in 'Last name',              with: 'Johnson'
    fill_in 'Email',                  with: 'example' + rand(1..500).to_s + '@example.com'
    fill_in 'Phone',                  with: '5108574932'
    fill_in 'Address line 1',         with: '2017 Mission St'
    fill_in 'Address line 2',         with: '2nd Fl'
    fill_in 'City',                   with: 'Orinda'
    fill_in 'State',                  with: 'CA'
    fill_in 'Zip',                    with: '94709'
    select 'Organizer',               from: 'employee_title'
    fill_in 'Hourly pay',             with: 12
    select '2013',                    from: 'employee_hire_date_1i'
    select 'August',                  from: 'employee_hire_date_2i'
    select '12',                      from: 'employee_hire_date_3i'
    select 'M',                       from: 'employee_gender'
    select 'Single',                  from: 'employee_fed_filing_status'
    select 'Single',                  from: 'employee_ca_filing_status'
    select '2',                       from: 'employee_ca_allowances'
    select '2',                       from: 'employee_fed_allowances'
    select '1984',                    from: 'employee_hire_date_1i'
    select 'August',                  from: 'employee_hire_date_2i'
    select '23',                      from: 'employee_hire_date_3i'

  end


  #### AS SUPERADMIN USER ####
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

    describe 'new employee' do

      before { visit new_employee_path }

      describe 'page' do
        it { should have_title('Staffnet:New employee') }
        it { should have_selector('h1', text: 'New employee') }
      end


    end
  end


end