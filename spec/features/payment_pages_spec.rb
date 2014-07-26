require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'PaymentPages' do
  
  subject { page }

  super_admin = FactoryGirl.create(:super_admin)
  manager = FactoryGirl.create(:manager)
  #staff = FactoryGirl.create(:staff)

  super_admin_employee = FactoryGirl.create(:employee, user: super_admin)
  #manager_employee = FactoryGirl.create(:employee, user: manager)
  #staff_employee = FactoryGirl.create(:employee, user: staff)
  shift = FactoryGirl.create(:shift, employee: super_admin_employee)

  supporter = FactoryGirl.create(:supporter)
  donation = FactoryGirl.create(:donation, shift: shift, supporter: supporter)
  payment = FactoryGirl.create(:payment, donation: donation)
  #payment_profile = FactoryGirl.create(:payment_profile, supporter: supporter)
  #payment = FactoryGirl.create(:payment, donation: donation,
  #                                      payment_profile: payment_profile)

  #### AS SUPERADMIN USER ####

  # log in as superadmin user to test basic functionality of the pages.
  # Authorization is handled in the
  # policy specs


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
      before { visit new_donation_payment_path(donation) }
      describe 'page' do
        it { should have_title('Staffnet:New payment') }
        it { should have_selector('h1', text: 'New payment') }
        it { should have_content(supporter.full_name) }
        it { should have_content(donation.date) }
      end
    end

    describe 'show' do
      before { visit donation_payment_path(donation, payment) }
      describe 'page' do
        describe 'page' do
          it { should have_content (supporter.full_name) }
        end
        # no way to edit or delete payments for now
        # describe 'links' do
        #   it { should have_link('edit', href: edit_payment_path(payment)) }
        #   it { should have_link('delete', href: payment_path(payment)) }
        # end
      end
    end
  end
end