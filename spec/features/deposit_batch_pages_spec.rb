require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'DepositBatchPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }

  let(:deposit_batch) { FactoryGirl.create(:deposit_batch) }

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
        visit deposit_batches_path
      end
      describe 'page' do
        it { should have_title('Staffnet:Review batches') }
      end
    end

    describe 'show' do
      before { visit deposit_batch_path(deposit_batch) }
      describe 'page' do
        it { should have_title('Staffnet:Batch details') }
        it { should have_content(deposit_batch.batch_type.humanize) }
      end
    end
  end


end