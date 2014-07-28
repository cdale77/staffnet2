require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'DepositBatchPages' do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:manager) { FactoryGirl.create(:manager) }
  let!(:staff) { FactoryGirl.create(:staff) }

  let!(:payment) { FactoryGirl.create(:payment) }

  let!(:super_admin_employee) { FactoryGirl.create(:employee, user: super_admin) }
  let!(:manager_employee) { FactoryGirl.create(:employee, user: manager) }
  let!(:staff_employee) { FactoryGirl.create(:employee, user: staff) }

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

    describe 'review' do
      before do
        visit deposit_batches_review_path
      end
      describe 'page' do
        it { should have_title('Staffnet:Review batches') }
      end

    end

  end


end