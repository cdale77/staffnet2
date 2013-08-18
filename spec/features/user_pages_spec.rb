require 'spec_helper'

#for easy sign-in using Devise
#include Warden::Test::Helpers
#Warden.test_mode!

describe "UserPages" do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }

  #### AS SUPERADMIN USER ####
  describe 'as superadmin user' do

    before do
      visit new_user_session_path
      fill_in 'Email',    with: super_admin.email
      fill_in 'Password', with: super_admin.password
      click_button 'Sign in'
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
          fill_in 'First name',             with: 'Brad'
          fill_in 'Last name',              with: 'Johnson'
          fill_in 'Email',                  with: 'example' + rand(1..500).to_s + '@example.com'
          fill_in 'Password',               with: 'foobar7878'
          fill_in 'Confirmation',           with: 'foobar7878'
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
        FactoryGirl.create(:user, first_name: 'Bob', last_name: 'Smith', email: 'bob@example.com')
        FactoryGirl.create(:user, first_name: 'Ben', last_name: 'Jones',  email: 'ben@example.com')
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

  #### AS MANAGER USER ####

  #### AS STAFF USER ####

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
        FactoryGirl.create(:user, first_name: 'Bob', last_name: 'Smith', email: 'bob@example.com')
        FactoryGirl.create(:user, first_name: 'Ben', last_name: 'Jones',  email: 'ben@example.com')
        visit users_path
      end
      it { should_not have_title('All users') }
      it 'should not list each user' do
        User.all.each do |user|
          expect(page).to_not have_selector('td', text: user.first_name)
        end
      end
      it 'should not have show and edit links for users' do
        User.all.each do |user|
          expect(page).to_not have_link('details', user_path(user))
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

    describe 'show' do
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
  end
end