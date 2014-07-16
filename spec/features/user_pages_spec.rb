require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "UserPages" do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:manager) { FactoryGirl.create(:manager) }
  let!(:staff) { FactoryGirl.create(:staff) }
  let!(:user) { FactoryGirl.create(:user) }

  let!(:employee) { FactoryGirl.create(:employee, first_name: 'Jason') }
  let!(:super_admin_employee) { FactoryGirl.create(:employee, user: super_admin) }
  let!(:admin_employee) { FactoryGirl.create(:employee, user: admin) }
  let!(:manager_employee) { FactoryGirl.create(:employee, user: manager) }
  let!(:staff_employee) { FactoryGirl.create(:employee, user: staff) }
  let!(:user_employee) { FactoryGirl.create(:employee, user: user) }

  ### HELPERS ###
  def fill_in_example_user
    fill_in 'Email',                  with: 'example' + rand(1..500).to_s + '@example.com'
    fill_in 'Password',               with: 'foobar7878'
    fill_in 'Confirmation',           with: 'foobar7878'
  end

  #### AS SUPERADMIN USER ####

  describe 'as superadmin user' do

   before do
      visit new_user_session_path
      fill_in 'Email',    with: super_admin.email
      fill_in 'Password', with: super_admin.password
      click_button 'Sign in'
   end

   after do
     logout(:super_admin)
   end

    describe 'new user' do

      before  { visit new_user_path }

      it { should have_selector('h1', text: 'New user') }
      it { should have_title('Staffnet:New user') }

      describe 'with invalid information' do
        it 'should not create a new user' do
          expect { click_button 'Create User' }.not_to change(User, :count)
        end
        describe 'after clicking' do
          before { click_button 'Create User' }
          it { should have_content("error") }
        end
      end

      describe 'with valid information' do
        before do
          fill_in_example_user
          select 'Admin', from: 'user_role'
        end

        it 'should create a new user' do
          expect { click_button 'Create User' }.to change(User, :count).by(1)
        end
        describe 'after saving user' do
          before { click_button 'Create User' }

          it { should have_content('Admin') }
          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        5.times { FactoryGirl.create(:user) }
        visit users_path
      end
      it { should have_title('All users') }
      it 'should list each user' do
        User.all.each do |user|
          expect(page).to have_selector('td', text: user.email)
        end
      end
    end

    describe 'edit user' do
      before { visit edit_user_path(user) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit user') }
        it { should have_content('Role') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Email', with: 'notarealemail.com'
          click_button 'Update User'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        let(:new_first_name)  { 'New' }
        let(:new_last_name)   { 'Name' }
        let(:new_email) { 'new@example.com' }
        before do
          fill_in 'Email',            with: new_email
          select 'Admin',             from: 'user_role'
          click_button 'Update User'
        end


        it { should have_selector('div.alert.alert-success') }
        specify { expect(user.reload.email).to eq new_email }
        specify { expect(user.reload.role).to eq 'admin' }
      end
    end

    describe 'show' do
      before { visit user_path(user) }
      describe 'page' do
        it { should have_content (user.email) }
        describe 'links' do
          it { should have_link('edit', href: edit_user_path(user)) }
          it { should have_link('delete', href: user_path(user)) }
        end
      end
    end

    describe 'destroy' do
      before { visit user_path(user) }
      it 'should destroy a user' do
        expect { click_link 'delete' }.to change(User, :count).by(-1)
      end
    end
  end

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

    describe 'new user' do

      before  do
        visit new_user_path
      end

      describe 'page' do
        it { should_not have_content('Role') }
        it { should_not have_selector('h1', text: 'New user') }
        it { should_not have_title('Staffnet:New user') }
      end
    end

    describe 'index' do
      before do
        5.times { FactoryGirl.create(:user) }
        visit users_path
      end
      it { should have_title('All users') }
      it 'should list each user' do
        User.all.each do |user|
          expect(page).to have_selector('td', text: user.email)
        end
      end
    end

    describe 'edit user' do
      before { visit edit_user_path(user) }
      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit user') }
        it { should_not have_content('Role') }
      end
    end

    describe 'showing their own profile' do
      before { visit user_path(admin) }
      describe 'page' do
        it { should have_content (admin.email) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(admin)) }
          it { should_not have_link('delete', href: user_path(admin)) }
        end
      end
    end

    describe 'showing another user profile profile' do
      before { visit user_path(user) }
      describe 'page' do
        it { should have_content (user.email) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(user)) }
          it { should_not have_link('delete', href: user_path(user)) }
        end
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

    describe 'new user' do

      before  do
        visit new_user_path
      end

      it { should_not have_selector('h1', text: 'New user') }
      it { should_not have_title('Staffnet:New user') }
    end

    describe 'index' do
      it { should_not have_title('All users') }
    end

    describe 'edit user' do
      before { visit edit_user_path(user) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit user') }
      end
    end

    describe 'showing their own profile' do
      before { visit user_path(manager) }
      describe 'page' do
        it { should have_content (manager.email) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(manager)) }
          it { should_not have_link('delete', href: user_path(manager)) }
        end
      end
    end

    describe 'showing another user profile' do
      before { visit user_path(user) }
      describe 'page' do
        it { should_not have_content (user.email) }
      end
    end
  end

  #### AS STAFF USER ####
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

    describe 'new user' do

      before  do
        visit new_user_path
      end

      it { should_not have_selector('h1', text: 'New user') }
      it { should_not have_title('Staffnet:New user') }
    end

    describe 'index' do
      it { should_not have_title('All users') }
    end

    describe 'edit user' do
      before { visit edit_user_path(user) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit user') }
      end
    end

    describe 'showing their own profile' do
      before { visit user_path(staff) }
      describe 'page' do
        it { should have_content (staff.email) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(staff)) }
          it { should_not have_link('delete', href: user_path(staff)) }
        end
      end
    end

    describe 'showing another profile profile' do
      before { visit user_path(admin) }
      describe 'page' do
        it { should_not have_content (user.email) }
        end

    end
  end


  #### AS USER ####
  describe 'as regular user' do

    before do
      visit new_user_session_path
      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    describe 'new user' do

      before  do
        visit new_user_path
      end

      it { should_not have_selector('h1', text: 'New user') }
      it { should_not have_title('Staffnet:New user') }
    end

    describe 'index' do
      before do
        visit users_path
      end
      it { should_not have_title('All users') }
    end

    describe 'edit user' do
      before { visit edit_user_path(user) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit user') }
      end
    end

    describe 'showing their own profile' do
      before { visit user_path(user) }
      describe 'page' do
        it { should have_content (user.email) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(user)) }
          it { should_not have_link('delete', href: user_path(user)) }
        end
      end
    end

    describe 'showing another profile profile' do
      before { visit user_path(admin) }
      describe 'page' do
        it { should_not have_content (user.email) }
      end
    end
  end
end