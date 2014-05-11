require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ClientPages' do

  subject { page }

  let!(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:employee) { FactoryGirl.create(:employee, user_id: super_admin.id) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:client) { FactoryGirl.create(:client) }


  ### HELPERS ###

  def fill_in_example_client
    fill_in 'Client name',            with: 'Google'
    fill_in 'Address line 1',         with: '123 Main St'
    fill_in 'Address line 2',         with: 'Ste. 350'
    fill_in 'City',                   with: 'Mountain View'
    select  'California',             from: 'client_address_state'
    fill_in 'Zip',                    with: '94509'
    fill_in 'Contact name',           with: 'Larry Page'
    fill_in 'Contact phone',          with: '4158675309'
    fill_in 'Contact email',          with: 'larry@google.com'
    fill_in 'Web address',            with: 'https://www.google.com'
    fill_in 'Notes',                  with: 'Notes go here.'
  end

  def create_sample_clients
    FactoryGirl.create(:client, name: 'Test client 1')
    FactoryGirl.create(:client, name: 'Test client 2')
    FactoryGirl.create(:client, name: 'Test client 3')
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
          expect { click_button 'Create Client' }.not_to change(Client, :count)
        end
        describe 'after clicking' do
          before { click_button 'Create Client' }
          it { should have_content('error') }
        end
      end
      describe 'with valid information' do
        before { fill_in_example_client }
        it 'should create a new client' do
          expect { click_button 'Create Client' }.to change(Client, :count).by(1)
        end
        describe 'after saving client' do
          before { click_button 'Create Client' }
          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      describe 'page' do
        before { visit client_path(client) }
        describe 'page' do
          it { should have_content (client.name) }
          describe 'links' do
            it { should have_link('edit', href: edit_client_path(client)) }
            it { should have_link('delete', href: client_path(client)) }
          end
        end
      end
    end

    describe 'index' do
      before do
        create_sample_clients
        visit clients_path
      end

      after { Client.delete_all }

      describe 'page' do
        it { should have_title('All clients') }

        it 'should list each client' do
          Client.all.each do |client|
            expect(page).to have_content(client.name)
          end
        end
        it 'should have show and edit links for clients' do
          Client.all.each do |client|
            expect(page).to have_link('details', client_path(client))
            expect(page).to have_link('edit', client_path(client))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_client_path(client) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit client') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Contact email', with: 'notarealemail.com'
          click_button 'Update Client'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        let(:new_name)          { 'New name' }
        let(:contact_name)      { 'New contact' }
        let(:contact_email)     { 'new@example.com' }
        before do
          fill_in 'Name',             with: new_name
          fill_in 'Contact name',     with: contact_name
          fill_in 'Contact email',    with: contact_email
          click_button 'Update Client'

          it { should have_selector('div.alert.alert-success') }
          specify { expect(client.reload.name).to  eq new_name }
          specify { expect(client.reload.contact_email).to eq contact_email }
          specify { expect(client.reload.contact_name).to eq contact_name }
        end
      end
    end

    describe 'destroy' do
      before { visit client_path(client) }
      it 'should destroy an employee' do
        expect { click_link 'delete' }.to change(Client, :count).by(-1)
      end
    end
  end



  #### AS MANAGER USER ####

  # manager users should not see edit or destroy links

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
        before { visit client_path(client) }
        describe 'page' do
          describe 'links' do
            it { should_not have_link('edit', href: edit_client_path(client)) }
            it { should_not have_link('delete', href: client_path(client)) }
          end
        end
      end
    end

    describe 'index' do
      before do
        create_sample_clients
        visit clients_path
      end

      after { Client.delete_all }

      describe 'page' do
        it 'should have the right links' do
          Client.all.each do |client|
            expect(page).to have_link('details', client_path(client))
            expect(page).to_not have_link('edit', client_path(client))
          end
        end
      end
    end
  end
end