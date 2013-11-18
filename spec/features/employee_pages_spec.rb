require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!
describe 'EmployeePages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:employee) { FactoryGirl.create(:employee) }
  let!(:shift) { FactoryGirl.create(:shift, employee_id: employee.id) }

  ### HELPERS ###
  def fill_in_example_employee
    fill_in 'First name',               with: 'Brad'
    fill_in 'Last name',                with: 'Johnson'
    fill_in 'Email',                    with: 'example' + rand(1..500).to_s + '@example.com'
    fill_in 'Phone',                    with: '5108574932'
    fill_in 'Address line 1',           with: '2017 Mission St'
    fill_in 'Address line 2',           with: '2nd Fl'
    fill_in 'City',                     with: 'Orinda'
    select 'California',                from: 'employee_state'
    fill_in 'Zip',                      with: '94709'
    select 'Organizer',                 from: 'employee_title'
    fill_in 'Pay hrly',                 with: 12
    select 'M',                         from: 'employee_gender'
    select 'Single',                    from: 'employee_fed_filing_status'
    select 'Single',                    from: 'employee_ca_filing_status'
    fill_in 'employee_ca_allowances',   with: '2'
    fill_in 'employee_fed_allowances',  with: '2'
    fill_in 'Dob',                      with: '1980-09-01'
    fill_in 'Hire date',                with: '2013-09-01'
  end

  def create_sample_employees
    FactoryGirl.create(:employee, first_name: 'Bob', last_name: 'Smith')
    FactoryGirl.create(:employee, first_name: 'Ben', last_name: 'Jones')
  end



  #### AS SUPERADMIN USER ####

  ## log in as superadmin user to test basic functionality of the pages. Authorization is handled in the
  ## policy specs
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
      describe 'page' do
        before { visit employee_path(employee) }
        describe 'page' do
          it { should have_content (employee.first_name) }
          it { should have_content (employee.last_name) }
          describe 'links' do
            it { should have_link('edit', href: edit_employee_path(employee)) }
            it { should have_link('delete', href: employee_path(employee)) }
          end
          describe 'shifts' do
            it { should have_content(shift.shift_type.shift_type.titlecase)}
            it { should have_link('details', href: shift_path(shift)) }
          end
        end
      end
    end

    describe 'index' do
      before do
        create_sample_employees
        visit employees_path
      end

      after { Employee.delete_all }

      describe 'page' do
        it { should have_title('All employees') }

        it 'should list each employee' do
          Employee.all.each do |employee|
            expect(page).to have_content(employee.full_name)
            expect(page).to have_content(employee.email)
          end
        end
        it 'should have show and edit links for users' do
          Employee.all.each do |employee|
            expect(page).to have_link('details', employee_path(employee))
            expect(page).to have_link('edit', edit_employee_path(employee))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_employee_path(employee) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit employee') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Email', with: 'notarealemail.com'
          click_button 'Edit employee'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        let(:new_first_name)  { 'New' }
        let(:new_last_name)   { 'Name' }
        let(:new_email) { 'new@example.com' }
        before do
          fill_in 'First name',       with: new_first_name
          fill_in 'Last name',        with: new_last_name
          fill_in 'Email',            with: new_email
          click_button 'Edit employee'

          it { should have_selector('div.alert.alert-success') }
          specify { expect(employee.reload.first_name).to  eq new_first_name }
          specify { expect(employee.reload.email).to eq new_email }
        end
      end
    end

    describe 'destroy' do
      before { visit employee_path(employee) }
      it 'should destroy an employee' do
        expect { click_link 'delete' }.to change(Employee, :count).by(-1)
      end
    end
  end
end