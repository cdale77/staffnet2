require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ShiftPages' do

  subject { page }

  let!(:staff) { FactoryGirl.create(:staff) }
  let!(:super_admin) { FactoryGirl.create(:super_admin) }

  let!(:employee) { FactoryGirl.create(:employee,
                                       first_name: "Jason") }
  let!(:super_admin_employee) { FactoryGirl.create(:employee,
                                                   first_name: "SuperAdmin",
                                                   user: super_admin) }
  let!(:staff_employee) { FactoryGirl.create(:employee,
                                             first_name: "Staff",
                                             user: staff) }


  # pre-create a shift type so its in the database
  let!(:shift_type) { FactoryGirl.create(:shift_type, name: "door") }
  let!(:shift) { FactoryGirl.create(:shift) }
  let!(:donation) { FactoryGirl.create(:donation, shift_id: shift.id) }
  let!(:payment) { FactoryGirl.create(:payment, donation: donation) }

  ## HELPERS

  def fill_in_example_shift
    select "Door",                from: "shift_shift_type_id"
    fill_in "Date",               with: "2013-09-04"
    fill_in "Time in",            with: "09:00 AM"
    fill_in "Time out",           with: "05:00 PM"
  end

  def create_sample_shifts
    FactoryGirl.create(:shift, date: Date.yesterday)
    FactoryGirl.create(:shift, date: Date.today)
    FactoryGirl.create(:shift, employee_id: staff_employee.id)
    FactoryGirl.create(:shift, employee_id: staff_employee.id)
    FactoryGirl.create(:shift, employee_id: super_admin_employee.id)
    FactoryGirl.create(:shift, employee_id: super_admin_employee.id)
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

    describe 'new shift' do
      before do
        # create a ShiftType
        #shift_type = ShiftType.new(name: 'Door')
        #shift_type.save

        visit new_employee_shift_path(employee)
      end

      after { ShiftType.destroy_all }

      describe 'page' do
        it { should have_selector('h1', 'New shift') }
        it { should have_content(employee.full_name) }
      end

      describe 'with invalid information' do
        it 'should not create a new shift' do
          expect { click_button 'Create Shift' }.not_to change(Shift, :count)
        end
        describe 'after clicking' do
          before { click_button 'Create Shift' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_shift }

        it 'should create a new shift' do
          expect { click_button 'Create Shift' }.to change(Shift, :count).by(1)
        end
        describe 'after saving shift' do
          before { click_button 'Create Shift' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      before { visit shift_path(shift) }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift profile') }
        it { should have_content(shift.date) }
        it { should have_content(shift.employee.full_name) }
        describe 'links' do
          it { should have_link('edit', href: edit_shift_path(shift)) }
          it { should have_link('delete', href: shift_path(shift)) }
        end
        describe 'donations' do
          it { should have_content(donation.supporter.full_name) }
          it { should have_content(donation.amount.to_s) }
        end
      end
    end

    describe 'index' do
      before do
        create_sample_shifts
        visit shifts_path
      end

      after { Shift.delete_all }

      describe 'page' do
        it { should have_title('All shifts') }
        it 'should show each shift' do
          Shift.all.each do |shift|
            expect(page).to have_content(shift.date)
            expect(page).to have_content(shift.employee.last_name)
          end
        end
      end
    end

    describe 'edit' do
      before do
        visit edit_shift_path(shift)
      end

      describe 'page' do
        it { should have_title('Edit shift') }
        it { should have_selector('h1', 'Edit shift') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Date', with: ''
          click_button 'Update Shift'
        end
        it { should have_selector('div.alert-error') }
      end

=begin
      describe 'with valid information' do
        let(:new_note) { 'New note'}
        before do
          fill_in 'Notes', with: new_note
          click_button 'Update Shift'
        end
        it { should have_selector('div.alert-notice') }
        specify { expect(shift.reload.notes).to  eq new_note }
      end
=end
    end

    describe 'destroy' do
      before { visit shift_path(shift) }
      it 'should destroy a shift' do
        expect { click_link 'delete' }.to change(Shift, :count).by(-1)
      end
    end
  end


  #### AS STAFF USER ####
  ## using integration tests to test for the proper scope for Shift#index
  describe 'as staff user' do
    before do
      visit new_user_session_path
      fill_in 'Email',    with: staff.email
      fill_in 'Password', with: staff.password
      click_button 'Sign in'
    end

    after do
      logout(:super_admin)
    end

    describe 'index' do
      before do
        create_sample_shifts
        visit shifts_path
      end
      describe 'page' do
        it 'should show the correct users shifts' do
          expect(page).to have_content(staff_employee.first_name)
        end
        it 'should not show shifts for another user' do
          expect(page).to_not have_content(super_admin_employee.first_name)
        end
      end
    end
  end
end