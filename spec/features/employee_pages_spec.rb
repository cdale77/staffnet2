require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!
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
    select 'California',                      from: 'employee_state'
    fill_in 'Zip',                    with: '94709'
    select 'Organizer',               from: 'employee_title'
    fill_in 'Pay hourly',             with: 12
    select '2013',                    from: 'employee_hire_date_1i'
    select 'August',                  from: 'employee_hire_date_2i'
    select '12',                      from: 'employee_hire_date_3i'
    select 'M',                       from: 'employee_gender'
    #select 'Single',                  from: 'employee_fed_filing_status'
    #select 'Single',                  from: 'employee_ca_filing_status'
    fill_in 'Fed filing status',       with: 'single'
    fill_in 'Ca filing status',       with: 'single'
    #select '2',                       from: 'employee_ca_allowances'
    #select '2',                       from: 'employee_fed_allowances'
    fill_in 'Ca allowances',          with: '2'
    fill_in 'Fed allowances',         with: '2'
    select '2012',                    from: 'employee_hire_date_1i'
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

      describe 'with invalid information' do
        it 'should not create a new employee' do
          expect { click_button 'New employee' }.not_to change(Employee, :count)
        end
        describe 'after clicking' do
          before { click_button 'New employee' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_employee }

        it 'should create a new employee' do
          expect { click_button 'New employee' }.to change(Employee, :count).by(1)
        end
        describe 'after saving employee' do
          before { click_button 'New employee' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      before { visit employee_path(employee) }

      describe 'page' do
        describe 'page' do
          it { should have_content (employee.first_name) }
          it { should have_content (employee.last_name) }
          describe 'links' do
            it { should have_link('edit', href: edit_employee_path(employee)) }
            it { should have_link('delete', href: employee_path(employee)) }
          end
        end
      end
    end
  end


end