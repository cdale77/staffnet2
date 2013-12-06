require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'StaticPages' do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:employee) { FactoryGirl.create(:employee, user_id: super_admin.id) }

  #### AS SUPERADMIN USER ####

  ## log in as superadmin user to test basic functionality of the pages.

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
        describe 'links' do
          it { should have_link('View profile', employee_path(employee))}
        end

        describe 'footer' do
          it { should have_selector('h1', 'Staffnet home') }
          it { should have_link('Home', root_path) }
          it { should have_link('Sign out', destroy_user_session_path(super_admin)) }
        end
      end
    end

  end

end