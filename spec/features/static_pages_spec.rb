require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'StaticPages' do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:staff) { FactoryGirl.create(:staff) }
  let!(:employee) { FactoryGirl.create(:employee, user: super_admin) }
  let!(:staff_employee) { FactoryGirl.create(:employee, user: staff) }

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

    describe 'home' do
      before { visit root_path }

      describe 'page' do

        describe 'footer' do
          it { should have_link('Home', root_path) }
          it { should have_link('Sign out', destroy_user_session_path(super_admin)) }
        end
      end
    end
  end

  #### AS STAFF USER ####

  describe 'as super_admin user' do

    before do
      visit new_user_session_path
      fill_in 'Email',    with: staff.email
      fill_in 'Password', with: staff.password
      click_button 'Sign in'
    end

    after do
      logout(:staff)
    end

    describe 'home' do
      before { visit root_path }

      describe 'page' do
        describe 'footer' do
          it { should have_link('Home', root_path) }
          it { should have_link('Sign out', destroy_user_session_path(staff)) }
        end
      end
    end
  end

end