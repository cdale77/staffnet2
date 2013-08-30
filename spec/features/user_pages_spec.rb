require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "UserPages" do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }


  ### HELPERS ###
  def fill_in_example_user
    fill_in 'First name',             with: 'Brad'
    fill_in 'Last name',              with: 'Johnson'
    fill_in 'Email',                  with: 'example' + rand(1..500).to_s + '@example.com'
    fill_in 'Password',               with: 'foobar7878'
    fill_in 'Confirmation',           with: 'foobar7878'
  end

  def create_sample_users
    FactoryGirl.create(:user, first_name: 'Bob', last_name: 'Smith', email: 'bob@example.com')
    FactoryGirl.create(:user, first_name: 'Ben', last_name: 'Jones',  email: 'ben@example.com')
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
          expect { click_button 'New user' }.not_to change(User, :count)
        end
        describe 'after clicking' do
          before { click_button 'New user' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before do
          fill_in_example_user
        end
        it 'should create a new user' do
          expect { click_button 'New user' }.to change(User, :count).by(1)
        end
        describe 'after saving user' do
          before { click_button 'New user' }

          it { should have_title('Staffnet:Home') }
          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        create_sample_users
        visit users_path
      end
      it { should have_title('All users') }
      it 'should list each user' do
        User.all.each do |user|
          expect(page).to have_selector('td', text: user.first_name)
        end
      end
      it 'should have show and edit links for users' do
        User.all.each do |user|
          expect(page).to have_link('details', user_path(user))
          expect(page).to have_link('edit', edit_user_path(user))
        end
      end
    end

    describe 'edit user' do
      before { visit edit_user_path(user) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit user') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Email', with: 'notarealemail.com'
          click_button 'Edit user'
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
          click_button 'Edit user'
        end


        it { should have_selector('div.alert.alert-success') }
        specify { expect(user.reload.first_name).to  eq new_first_name }
        specify { expect(user.reload.email).to eq new_email }
      end
    end

    describe 'show' do
      before { visit user_path(user) }
      describe 'page' do
        it { should have_content (user.first_name) }
        it { should have_content (user.last_name) }
        describe 'links' do
          it { should have_link('edit', href: edit_user_path(user)) }
          it { should have_link('delete', href: user_path(user)) }
        end
      end
    end

    describe 'delete' do
      before { visit user_path(user) }
      it 'should delete a user' do
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

      it { should have_selector('h1', text: 'New user') }
      it { should have_title('Staffnet:New user') }

      describe 'with invalid information' do
        it 'should not create a new user' do
          expect { click_button 'New user' }.not_to change(User, :count)
        end
        describe 'after clicking' do
          before { click_button 'New user' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before do
          fill_in_example_user
        end
        it 'should create a new user' do
          expect { click_button 'New user' }.to change(User, :count).by(1)
        end
        describe 'after saving user' do
          before { click_button 'New user' }

          it { should have_title('Staffnet:Home') }
          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        create_sample_users
        visit users_path
      end
      it { should have_title('All users') }
      it 'should list each user' do
        User.all.each do |user|
          expect(page).to have_selector('td', text: user.first_name)
        end
      end
      it 'should have show and edit links for users' do
        User.all.each do |user|
          expect(page).to have_link('details', user_path(user))
          expect(page).to_not have_link('edit', edit_user_path(user))
        end
      end
    end

    describe 'edit user' do
      before { visit edit_user_path(user) }

      describe 'page' do
        it { should_not have_selector('h1', text: 'Edit user') }
      end
    end

    describe 'showing their own profile' do
      before { visit user_path(admin) }
      describe 'page' do
        it { should have_content (admin.first_name) }
        it { should have_content (admin.last_name) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(admin)) }
          it { should have_link('delete', href: user_path(admin)) }
        end
      end
    end

    describe 'showing another user profile profile' do
      before { visit user_path(user) }
      describe 'page' do
        it { should have_content (admin.first_name) }
        it { should have_content (admin.last_name) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(user)) }
          it { should have_link('delete', href: user_path(user)) }
        end
      end
    end

    describe 'delete' do
      before { visit user_path(user) }
      it 'should delete a user' do
        expect { click_link 'delete' }.to change(User, :count).by(-1)
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
        it { should have_content (manager.first_name) }
        it { should have_content (manager.last_name) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(manager)) }
          it { should_not have_link('delete', href: user_path(manager)) }
        end
      end
    end

    describe 'showing another user profile' do
      before { visit user_path(user) }
      describe 'page' do
        it { should_not have_content (user.first_name) }
        it { should_not have_content (user.last_name) }
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
        it { should have_content (staff.first_name) }
        it { should have_content (user.last_name) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(staff)) }
          it { should_not have_link('delete', href: user_path(staff)) }
        end
      end
    end

    describe 'showing another profile profile' do
      before { visit user_path(admin) }
      describe 'page' do
        it { should_not have_content (user.first_name) }
        it { should_not have_content (user.last_name) }
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
        it { should have_content (user.first_name) }
        it { should have_content (user.last_name) }
        describe 'links' do
          it { should_not have_link('edit', href: edit_user_path(user)) }
          it { should_not have_link('delete', href: user_path(user)) }
        end
      end
    end

    describe 'showing another profile profile' do
      before { visit user_path(admin) }
      describe 'page' do
        it { should_not have_content (user.first_name) }
        it { should_not have_content (user.last_name) }
      end
    end
  end
end