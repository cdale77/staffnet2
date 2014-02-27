require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'SendyListPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }

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

    describe 'new list' do
      before { visit new_sendy_list_path }

      describe 'page' do
        it { should have_title('Staffnet:New Sendy list') }
        it { should have_selector('h1', text: 'New Sendy list') }
      end
    end
  end
end