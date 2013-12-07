require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'SupporterPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }

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

    describe 'new supporter' do

      before { visit new_supporter_path }

      describe 'page' do
        it { should have_title('Staffnet:New supporter') }
        it { should have_selector('h1', text: 'New supporter') }
      end
    end
  end
end