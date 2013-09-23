require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ShiftPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }

  let!(:employee) { FactoryGirl.create(:employee, first_name: 'Jason') }

  let!(:shift) { FactoryGirl.create(:shift) }


  ## HELPERS

  def fill_in_example_shift
    select employee.full_name,    from: 'shift_employee_id'
    fill_in 'Date',               with: '2013-09-04'
    fill_in 'Time in',            with: '09:00 AM'
    fill_in 'Time out',           with: '05:00 PM'
  end

  def create_sample_shifts
    FactoryGirl.create(:shift, date: Date.yesterday)
    FactoryGirl.create(:shift, date: Date.today)
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
      before { visit new_shift_path }

      describe 'page' do
        it { should have_selector('h1', 'New shift') }

      end

      describe 'with invalid information' do
        it 'should not create a new shift' do
          expect { click_button 'New shift' }.not_to change(Shift, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_shift }

        it 'should create a new shift' do
          expect { click_button 'New shift' }.to change(Shift, :count).by(1)
        end
        describe 'after saving shift' do
          before { click_button 'New shift' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      before { visit shift_path(shift) }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift details') }
        it { should have_content(shift.date) }
        it { should have_content(shift.employee.full_name) }
        describe 'links' do
          it { should have_link('edit', href: edit_shift_path(shift)) }
          it { should have_link('delete', href: shift_path(shift)) }
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
        it 'should have details and edit links for each shift do' do
          Shift.all.each do |shift|
            expect(page).to have_link('details', shift_path(shift))
            expect(page).to have_link('edit', edit_shift_path(shift))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_shift_path(shift) }

      describe 'page' do
        it { should have_title('Edit shift') }
        it { should have_selector('h1', 'Edit shift') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Date', with: ''
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        new_note = "This is a new note."
        before do
          fill_in 'Notes', with: new_note
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert.alert-success') }
        specify { expect(shift.reload.notes).to  eq new_note }
      end
    end

    describe 'destroy' do
      before { visit shift_path(shift) }
      it 'should destroy a shift' do
        expect { click_link 'delete' }.to change(Shift, :count).by(-1)
      end
    end
  end
=begin

  #### AS ADMIN USER ####
  describe 'as admin user' do
    before do
      visit new_user_session_path
      fill_in 'Email',    with: admin.email
      fill_in 'Password', with: admin.password
      click_button 'Sign in'
    end

    after do
      logout(:admin)
    end

    describe 'new shift' do
      before { visit new_shift_path }

      describe 'page' do
        it { should have_selector('h1', 'New shift') }

      end

      describe 'with invalid information' do
        it 'should not create a new shift' do
          expect { click_button 'New shift' }.not_to change(Shift, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_shift }

        it 'should create a new shift' do
          expect { click_button 'New shift' }.to change(Shift, :count).by(1)
        end
        describe 'after saving shift' do
          before { click_button 'New shift' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      before { visit shift_path(shift) }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift details') }
        it { should have_content(shift.date) }
        it { should have_content(shift.employee.full_name) }
        describe 'links' do
          it { should have_link('edit', href: edit_shift_path(shift)) }
          it { should have_link('delete', href: shift_path(shift)) }
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
        it 'should have details and edit links for each shift do' do
          Shift.all.each do |shift|
            expect(page).to have_link('details', shift_path(shift))
            expect(page).to have_link('edit', edit_shift_path(shift))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_shift_path(shift) }

      describe 'page' do
        it { should have_title('Edit shift') }
        it { should have_selector('h1', 'Edit shift') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Date', with: ''
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        new_note = "This is a new note."
        before do
          fill_in 'Notes', with: new_note
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert.alert-success') }
        specify { expect(shift.reload.notes).to  eq new_note }
      end
    end

    describe 'destroy' do
      before { visit shift_path(shift) }
      it 'should destroy a shift' do
        expect { click_link 'delete' }.to change(Shift, :count).by(-1)
      end
    end
  end

  #### AS MANAGER USER ####
  describe 'as manager user' do
    before do
      visit new_user_session_path
      fill_in 'Email',    with: manager.email
      fill_in 'Password', with: manager.password
      click_button 'Sign in'
    end

    after do
      logout(:manager)
    end

    describe 'new shift' do
      before { visit new_shift_path }

      describe 'page' do
        it { should have_selector('h1', 'New shift') }

      end

      describe 'with invalid information' do
        it 'should not create a new shift' do
          expect { click_button 'New shift' }.not_to change(Shift, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_shift }

        it 'should create a new shift' do
          expect { click_button 'New shift' }.to change(Shift, :count).by(1)
        end
        describe 'after saving shift' do
          before { click_button 'New shift' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      before { visit shift_path(shift) }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift details') }
        it { should have_content(shift.date) }
        it { should have_content(shift.employee.full_name) }
        describe 'links' do
          it { should have_link('edit', href: edit_shift_path(shift)) }
          it { should have_link('delete', href: shift_path(shift)) }
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
        it 'should have details and edit links for each shift do' do
          Shift.all.each do |shift|
            expect(page).to have_link('details', shift_path(shift))
            expect(page).to have_link('edit', edit_shift_path(shift))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_shift_path(shift) }

      describe 'page' do
        it { should have_title('Edit shift') }
        it { should have_selector('h1', 'Edit shift') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Date', with: ''
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        new_note = "This is a new note."
        before do
          fill_in 'Notes', with: new_note
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert.alert-success') }
        specify { expect(shift.reload.notes).to  eq new_note }
      end
    end

    describe 'destroy' do
      before { visit shift_path(shift) }
      it 'should destroy a shift' do
        expect { click_link 'delete' }.to change(Shift, :count).by(-1)
      end
    end
  end

  #### STAFF USER ####
  describe 'as staff user' do
    before do
      visit new_user_session_path
      fill_in 'Email',    with: staff.email
      fill_in 'Password', with: staff.password
      click_button 'Sign in'
    end

    after do
      logout(:staff)
    end

    describe 'new shift' do
      before { visit new_shift_path }

      describe 'page' do
        it { should have_selector('h1', 'New shift') }

      end

      describe 'with invalid information' do
        it 'should not create a new shift' do
          expect { click_button 'New shift' }.not_to change(Shift, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_shift }

        it 'should create a new shift' do
          expect { click_button 'New shift' }.to change(Shift, :count).by(1)
        end
        describe 'after saving shift' do
          before { click_button 'New shift' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      before { visit shift_path(shift) }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift details') }
        it { should have_content(shift.date) }
        it { should have_content(shift.employee.full_name) }
        describe 'links' do
          it { should have_link('edit', href: edit_shift_path(shift)) }
          it { should have_link('delete', href: shift_path(shift)) }
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
        it 'should have details and edit links for each shift do' do
          Shift.all.each do |shift|
            expect(page).to have_link('details', shift_path(shift))
            expect(page).to have_link('edit', edit_shift_path(shift))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_shift_path(shift) }

      describe 'page' do
        it { should have_title('Edit shift') }
        it { should have_selector('h1', 'Edit shift') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Date', with: ''
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        new_note = "This is a new note."
        before do
          fill_in 'Notes', with: new_note
          click_button 'Edit shift'
        end
        it { should have_selector('div.alert.alert-success') }
        specify { expect(shift.reload.notes).to  eq new_note }
      end
    end

    describe 'destroy' do
      before { visit shift_path(shift) }
      it 'should destroy a shift' do
        expect { click_link 'delete' }.to change(Shift, :count).by(-1)
      end
    end
  end

  #### AS REGULAR USER ####
  describe 'as regular user' do
    before do
      visit new_user_session_path
      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    after do
      logout(:user)
    end

    describe 'new shift' do
      before { visit new_shift_path }

      describe 'page' do
        it { should_not have_selector('h1', 'New shift') }

      end
    end

    describe 'show' do
      before { visit shift_path(shift) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Shift details') }
        it { should_not have_content(shift.date) }
        it { should_not have_content(shift.employee.full_name) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_shift_path(shift)) }
          it { should_not have_link('delete', href: shift_path(shift)) }
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
        it { should_not have_title('All shifts') }
        it 'should not show each shift' do
          Shift.all.each do |shift|
            expect(page).to_not have_content(shift.date)
            expect(page).to_not have_content(shift.employee.last_name)
          end
        end
        it 'should have not details and edit links for each shift do' do
          Shift.all.each do |shift|
            expect(page).to_not have_link('details', shift_path(shift))
            expect(page).to_not have_link('edit', edit_shift_path(shift))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_shift_path(shift) }

      describe 'page' do
        it { should_not have_title('Edit shift') }
        it { should_not have_selector('h1', 'Edit shift') }
      end
    end
  end
=end


end