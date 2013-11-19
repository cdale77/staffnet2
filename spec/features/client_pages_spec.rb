require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ClientPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }


  ### HELPERS ###

  def fill_in_example_client
    fill_in 'Name',                   with: 'Google'
    fill_in 'Address line 1',         with: '123 Main St'
    fill_in 'Address line 2',         with: 'Ste. 350'
    fill_in 'City',                   with: 'Mountain View'
    select  'California',             from: 'client_state'
    fill_in 'Zip',                    with: '94509'
    fill_in 'Contact name',           with: 'Larry Page'
    fill_in 'Contact phone',          with: '4158675309'
    fill_in 'Contact email',          with: 'larry@google.com'
    fill_in 'Web address',            with: 'https://www.google.com'
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

    describe 'new client' do

      before { visit new_client_path }

      describe 'page' do
        it { should have_title('Staffnet:New client') }
        it { should have_selector('h1', text: 'New client') }
      end

      describe 'with invalid information' do
        it 'should not create a new client' do
          expect { click_button 'New client' }.not_to change(Client, :count)
        end
        describe 'after clicking' do
          before { click_button 'New client' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_client }

        it 'should create a new client' do
          expect { click_button 'New client' }.to change(Client, :count).by(1)
        end
        describe 'after saving client' do
          before { click_button 'New client' }
          it { should have_selector('div.alert') }
        end
      end
    end
  end
end