require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'SupporterPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }

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

    describe 'new supporter' do

      before { visit new_supporter_path }

      describe 'page' do
        it { should have_title('Staffnet:New supporter') }
        it { should have_selector('h1', text: 'New supporter') }
      end

      describe 'with invalid information' do
        it 'should not create a new supporter' do
          expect { click_button 'New supporter' }.not_to change(Supporter, :count)
        end
        describe 'after clicking' do
          before { click_button 'New supporter' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_supporter }

        it 'should create a new supporter' do
          expect { click_button 'New supporter' }.to change(Supporter, :count).by(1)
        end
        describe 'after saving supporter' do
          before { click_button 'New supporter' }

          it { should have_selector('div.alert') }
        end
      end
    end
  end
end