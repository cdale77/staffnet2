require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'SupporterPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let!(:supporter_type) { FactoryGirl.create(:supporter_type) } # so there's a supporter type to pick for #new

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:donation) { FactoryGirl.create(:donation, supporter_id: supporter.id) }

  ### HELPERS ###
  def fill_in_example_supporter
    fill_in 'Last name', with: 'Doe'
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

      before { visit new_supporter_path }

      describe 'page' do
        it { should have_title('Staffnet:New supporter') }
        it { should have_selector('h1', text: 'New supporter') }
      end

      describe 'with invalid information' do
        it 'should not create a new supporter' do
          expect { click_button 'Create Supporter' }.not_to change(Supporter, :count)
        end
        describe 'after clicking' do
          before { click_button 'Create Supporter' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_supporter }

        it 'should create a new supporter' do
          expect { click_button 'Create Supporter' }.to change(Supporter, :count).by(1)
        end
        describe 'after saving supporter' do
          before { click_button 'Create Supporter' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      describe 'page' do
        before { visit supporter_path(supporter) }
        describe 'page' do
          it { should have_content (supporter.full_name) }
          describe 'links' do
            it { should have_link('edit', href: edit_supporter_path(supporter)) }
            it { should have_link('delete', href: supporter_path(supporter)) }
          end
          describe 'donations' do
            it { should have_link('New donation', href: new_supporter_donation_path(supporter)) }
            it { should have_link('details', href: donation_path(donation)) }
          end
        end
      end
    end

    describe 'index' do
      before do
        5.times { FactoryGirl.create(:supporter) }
        visit supporters_path
      end

      after { Supporter.delete_all }

      describe 'page' do
        it 'should list all supporters' do
          Supporter.all.each do |supporter|
            expect(page).to have_content(supporter.full_name)
          end
        end
        it 'should have the correct links' do
          Supporter.all.each do |supporter|
            expect(page).to have_link('details', supporter_path(supporter))
            expect(page).to have_link('edit', edit_supporter_path(supporter))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_supporter_path(supporter) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit supporter') }
      end
      describe 'with invalid information' do
        before do
          fill_in 'Primary email', with: 'notarealemail.com'
          click_button 'Update Supporter'
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
          fill_in 'Primary email',            with: new_email
          click_button 'Update Employee'

          it { should have_selector('div.alert.alert-success') }
          specify { expect(supporter.reload.first_name).to  eq new_first_name }
          specify { expect(supporter.reload.last_name).to eq new_last_name}
          specify { expect(supporter.reload.email1).to eq new_email }
        end
      end
    end

    describe 'destroy' do
      before { visit supporter_path(supporter) }
      it 'should destroy a supporter' do
        expect { click_link 'delete' }.to change(Supporter, :count).by(-1)
      end
    end
  end

  #### AS MANAGER USER ####

  # manager users should not see edit or delete links
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
        before { visit supporter_path(supporter) }
        describe 'page' do
          describe 'links' do
            it { should_not have_link('edit', href: edit_supporter_path(supporter)) }
            it { should_not have_link('delete', href: supporter_path(supporter)) }
          end
        end
      end
    end

    describe 'index' do
      before do
        5.times { FactoryGirl.create(:supporter) }
        visit supporters_path
      end

      after { Supporter.delete_all }

      describe 'page' do
        it 'should have the right links' do
          Supporter.all.each do |supporter|
            expect(page).to have_link('details', supporter_path(supporter))
            expect(page).to_not have_link('edit', edit_supporter_path(supporter))
          end
        end
      end
    end
  end
end