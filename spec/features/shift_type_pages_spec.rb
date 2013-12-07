require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ShiftTypePages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }

  let(:shift_type) { FactoryGirl.create(:shift_type) }


  ## HELPERS ##

  def create_sample_shift_types
    FactoryGirl.create(:shift_type, name: 'door')
    FactoryGirl.create(:shift_type, name: 'office')
    FactoryGirl.create(:shift_type, name: 'vacation')
    FactoryGirl.create(:shift_type, name: 'sick')
  end

  ## AS SUPERADMIN USER ##
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

    describe 'new shift type' do
      before { visit new_shift_type_path }

      describe 'page' do
        it { should have_selector('h1', text: 'New shift type') }
      end

      describe 'with invalid information' do
        it 'should not create a shift_type' do
          expect { click_button 'New shift type' }.not_to change(ShiftType, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift type' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in 'Name', with: 'Tabling' }

        it 'should create a new shift_type' do
          expect { click_button 'New shift type' }.to change(ShiftType, :count).by(1)
        end
        describe 'after saving shift type' do
          before { click_button 'New shift type' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        create_sample_shift_types
        visit shift_types_path
      end

      after { ShiftType.delete_all }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift types') }

        it 'should list each shift type' do
          ShiftType.all.each do |shift_type|
            expect(page).to have_content(shift_type.name)
          end
        end

        it 'should have edit and delete links for each shift type' do
          ShiftType.all.each do |shift_type|
            expect(page).to have_link('edit', edit_shift_type_path(shift_type))
            expect(page).to have_link('delete', shift_type_path(shift_type))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_shift_type_path(shift_type) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit shift type') }

      end

      describe 'with invalid information' do
        invalid_shift_type = 'a' * 80
        before  do
          fill_in 'Name', with: invalid_shift_type
          click_button 'Edit shift type'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        valid_shift_type = 'Newshift'
        before  do
          fill_in 'Name', with: valid_shift_type
          click_button 'Edit shift type'
        end
        it { should have_selector('div.alert-success') }
        specify { expect(shift_type.reload.name).to eq 'Newshift' }
      end
    end
  end

  ## AS ADMIN USER
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

    describe 'new shift type' do
      before { visit new_shift_type_path }

      describe 'page' do
        it { should have_selector('h1', text: 'New shift type') }
      end

      describe 'with invalid information' do
        it 'should not create a shift_type' do
          expect { click_button 'New shift type' }.not_to change(ShiftType, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift type' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in 'Name', with: 'Tabling' }

        it 'should create a new shift_type' do
          expect { click_button 'New shift type' }.to change(ShiftType, :count).by(1)
        end
        describe 'after saving shift type' do
          before { click_button 'New shift type' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        create_sample_shift_types
        visit shift_types_path
      end

      after { ShiftType.delete_all }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift types') }

        it 'should list each shift type' do
          ShiftType.all.each do |shift_type|
            expect(page).to have_content(shift_type.name)
          end
        end

        it 'should have edit and delete links for each shift type' do
          ShiftType.all.each do |shift_type|
            expect(page).to have_link('edit', edit_shift_type_path(shift_type))
            expect(page).to have_link('delete', shift_type_path(shift_type))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_shift_type_path(shift_type) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit shift type') }

      end

      describe 'with invalid information' do
        invalid_shift_type = 'a' * 80
        before  do
          fill_in 'Name', with: invalid_shift_type
          click_button 'Edit shift type'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        valid_shift_type = 'Newshift'
        before  do
          fill_in 'Name', with: valid_shift_type
          click_button 'Edit shift type'
        end
        it { should have_selector('div.alert-success') }
        specify { expect(shift_type.reload.name).to eq 'Newshift' }
      end
    end
  end

  ## AS MANAGER USER
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

    describe 'new shift type' do
      before { visit new_shift_type_path }

      describe 'page' do
        it { should_not have_selector('h1', text: 'New shift type') }
      end
    end

    describe 'index' do
      before { visit shift_types_path }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Shift types') }
      end
    end

    describe 'edit' do
      before { visit edit_shift_type_path(shift_type) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit shift type') }
      end
    end
  end

  ## AS STAFF USER
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

    describe 'new shift type' do
      before { visit new_shift_type_path }

      describe 'page' do
        it { should_not have_selector('h1', text: 'New shift type') }
      end
    end

    describe 'index' do
      before { visit shift_types_path }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Shift types') }
      end
    end

    describe 'edit' do
      before { visit edit_shift_type_path(shift_type) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit shift type') }
      end
    end
  end

  ## AS REGULAR USER
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

    describe 'new shift type' do
      before { visit new_shift_type_path }

      describe 'page' do
        it { should_not have_selector('h1', text: 'New shift type') }
      end
    end

    describe 'index' do
      before { visit shift_types_path }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Shift types') }
      end
    end

    describe 'edit' do
      before { visit edit_shift_type_path(shift_type) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit shift type') }
      end
    end
  end

end