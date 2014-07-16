require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'DonationPages' do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:manager) { FactoryGirl.create(:manager) }
  let!(:staff) { FactoryGirl.create(:staff) }

  let!(:super_admin_employee) { FactoryGirl.create(:employee,
                                                   user: super_admin) }
  let!(:manager_employee) { FactoryGirl.create(:employee,
                                               user: manager) }
  let!(:staff_employee) { FactoryGirl.create(:employee,
                                             user: staff) }
  let!(:shift) { FactoryGirl.create(:shift,
                                    employee: super_admin_employee) }

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:donation) { FactoryGirl.create(:donation,
                                       shift: shift) }
  let!(:payment_profile) { FactoryGirl.create(:payment_profile,
                                              supporter: supporter) }
  let!(:payment) { FactoryGirl.create(:payment,
                                      donation: donation,
                                      payment_profile: payment_profile) }


  
  ### HELPERS ###

  def fill_in_example_donation
    fill_in 'Date',               with: '2014-01-02'
    fill_in 'Amount',             with: 10.00
    select 'Cash',                from: 'donation[donation_type]'
    select 'Phone',               from: 'donation_source'
    select 'Prop 13',             from: 'donation_campaign'

  end

  def fill_in_sustainer_donation
    fill_in 'Date',               with: '2014-01-02'
    fill_in 'Amount',             with: 10.00
    select 'Cash',                from: 'Donation type'
    select 'Phone',               from: 'donation_source'
    select 'Prop 13',             from: 'donation_campaign'
    select 'Quarterly',           from: 'Sustainer frequency'
    #find("#payment-profile-id", visible: false).set(payment_profile.id)
    find("#payment-type", visible: false).set('cash')
    find("#payment-amount", visible: false).set(10.00)

  end

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
          it { should have_content('Month code') }
        end
      end

      describe 'with valid sustainer information' do
        before { fill_in_sustainer_donation }
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
        end
      end
    end

    describe 'index' do
      before do
        5.times { FactoryGirl.create(:donation) }
        visit donations_path
      end

      after { Donation.delete_all }

      describe 'page' do
        it 'should list all donations' do
          Donation.all.each do |donation|
            expect(page).to have_content(donation.supporter.full_name)
          end
        end
      end
    end

    describe 'edit' do
      before do
        visit edit_donation_path(donation)
      end

      describe 'page' do
        it { should have_title('Edit donation') }
        it { should have_selector('h1', 'Edit donation') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Date', with: ''
          click_button 'Update Donation'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        let(:new_note) { 'New note'}
        before do
          fill_in 'Notes', with: new_note
          click_button 'Update Donation'
        end
        it { should have_selector('div.alert.alert-success') }
        specify { expect(donation.reload.notes).to  eq new_note }
      end
    end

    describe 'destroy' do
      before { visit donation_path(donation) }
      it 'should destroy a donation' do
        expect { click_link 'delete' }.to change(Donation, :count).by(-1)
      end
    end

  end

  ## AS MANAGER USER
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

    describe 'show' do
      describe 'page' do
        before { visit donation_path(donation) }
        describe 'page' do
          it { should have_content (supporter.full_name) }
          describe 'links' do
            it { should_not have_link('edit', href: edit_donation_path(donation)) }
            it { should_not have_link('delete', href: donation_path(donation)) }
          end
        end
      end
    end

    describe 'index' do
      before do
        5.times { FactoryGirl.create(:donation) }
        visit donations_path
      end

      after { Donation.delete_all }

      describe 'page' do
        it 'should list all donations' do
          Donation.all.each do |donation|
            expect(page).to have_content(donation.supporter.full_name)
          end
        end
      end
    end
  end
end