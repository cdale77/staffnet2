require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'DonationPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:manager) { FactoryGirl.create(:manager) }

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:donation) { FactoryGirl.create(:donation) }
  let!(:payment) { FactoryGirl.create(:payment, donation_id: donation.id) }
  ### HELPERS ###

  def fill_in_example_donation
    fill_in 'Date',               with: '2014-01-02'
    fill_in 'Amount',             with: 10.00
    select 'Cash',                from: 'donation_donation_type'
    select 'Phone',               from: 'donation_source'
    select 'Prop 13',             from: 'donation_campaign'
  end

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

    describe 'new' do

      before { visit new_supporter_donation_path(supporter) }

      describe 'page' do
        it { should have_title('Staffnet:New donation') }
        it { should have_selector('h1', text: 'New donation') }
        it { should have_content(supporter.full_name)}
      end

      describe 'with invalid information' do
        it 'should not create a new donation' do
          expect { click_button 'Create Donation' }.not_to change(Donation, :count)
        end
        describe 'after clicking' do
          before { click_button 'Create Donation' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_donation }

        it 'should create a new donation' do
          expect { click_button 'Create Donation' }.to change(Donation, :count).by(1)
        end
        describe 'after saving donation' do
          before { click_button 'Create Donation' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      describe 'page' do
        before { visit donation_path(donation) }
        describe 'page' do
          it { should have_content (supporter.full_name) }
          describe 'links' do
            it { should have_link('edit', href: edit_donation_path(donation)) }
            it { should have_link('delete', href: donation_path(donation)) }
          end
          describe 'payments' do
            it { should have_link('New payment', href: new_donation_payment_path(donation)) }
            it { should have_link('details', href: payment_path(payment)) }
          end
        end
      end
    end
  end
end