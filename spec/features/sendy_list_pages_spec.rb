require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'SendyListPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }

  let!(:supporter_type) { FactoryGirl.create(:supporter_type, name: 'supporter') } # so there's a supporter type to pick for #new

  ## HELPERS ##

  def create_sample_sendy_lists
    %w[members donors officials].each do |list|
      FactoryGirl.create(:sendy_list, name: list)
    end
  end

  def fill_in_example_sendy_list
    fill_in 'Name',                   with: 'supporters'
    fill_in 'Sendy list identifier',  with: '2243432er23d12'
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
      before { visit new_sendy_list_path }

      describe 'page' do
        it { should have_title('Staffnet:New Sendy list') }
        it { should have_selector('h1', text: 'New Sendy list') }
      end

      describe 'with invalid information' do
        it 'should not create a new supporter' do
          expect { click_button 'Create Sendy list' }.not_to change(SendyList, :count)
        end
        describe 'after clicking' do
          before { click_button 'Create Sendy list' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_sendy_list }

        it 'should create a new sendy list' do
          expect { click_button 'Create Sendy list' }.to change(SendyList, :count).by(1)
        end
        describe 'after saving a sendy list' do
          before { click_button 'Create Sendy list' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        create_sample_sendy_lists
        visit sendy_lists_path
      end

      after { SendyList.destroy_all }

      describe 'page' do
        it { should have_selector('h1', text: 'Sendy lists') }

        it 'should list each list' do
          SendyList.all.each do |list|
            expect(page).to have_content(list.name)
          end
        end

        it 'should have edit and delete links for each list' do
          SendyList.all.each do |list|
            expect(page).to have_link('edit', edit_sendy_list_path(list))
          end
        end
      end
    end
  end
end