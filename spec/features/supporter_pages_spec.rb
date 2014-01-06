require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'SupporterPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:supporter_type) { FactoryGirl.create(:supporter_type) } # so there's a supporter type to pick for #new
  let(:supporter) { FactoryGirl.create(:supporter) }

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
          it { should have_content (supporter.first_name) }
          it { should have_content (supporter.last_name) }
          describe 'links' do
            it { should have_link('edit', href: edit_supporter_path(supporter)) }
            it { should have_link('delete', href: supporter_path(supporter)) }
          end
        end
      end
    end
  end
end