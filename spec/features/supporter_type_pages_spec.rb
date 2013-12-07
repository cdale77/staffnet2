require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'SupporterTypePages' do
  
  subject { page }

  let(:supporter_type) { FactoryGirl.create(:supporter_type) }
  let(:super_admin) { FactoryGirl.create(:super_admin) }

  ## HELPERS ##

  def create_sample_supporter_types
    ['donor', 'supporter', 'official'].each do |supporter_type|
      SupporterType.new(name: supporter_type).save
    end
  end

  ## AS SUPERADMIN USER ##
  before do
    visit new_user_session_path
    fill_in 'Email',    with: super_admin.email
    fill_in 'Password', with: super_admin.password
    click_button 'Sign in'
  end

  after do
    logout(:super_admin)
  end

  describe 'new supporter type' do
    before { visit new_supporter_type_path }

    describe 'page' do
      it { should have_selector('h1', text: 'New supporter type') }
    end

    describe 'with invalid information' do
      it 'should not create a supporter_type' do
        expect { click_button 'New supporter type' }.not_to change(SupporterType, :count)
      end
      describe 'after clicking' do
        before { click_button 'New supporter type' }
        it { should have_content('error') }
      end
    end

    describe 'with valid information' do
      before { fill_in 'Name', with: 'Press' }

      it 'should create a new supporter_type' do
        expect { click_button 'New supporter type' }.to change(SupporterType, :count).by(1)
      end
      describe 'after saving supporter type' do
        before { click_button 'New supporter type' }

        it { should have_selector('div.alert') }
      end
    end
  end

  describe 'index' do
    before do
      create_sample_supporter_types
      visit supporter_types_path
    end

    after { SupporterType.delete_all }

    describe 'page' do
      it { should have_selector('h1', text: 'Supporter types') }

      it 'should list each supporter type' do
        SupporterType.all.each do |supporter_type|
          expect(page).to have_content(supporter_type.name)
        end
      end

      it 'should have edit links for each supporter type' do
        SupporterType.all.each do |supporter_type|
          expect(page).to have_link('edit', edit_supporter_type_path(supporter_type))
        end
      end
    end
  end

  describe 'edit' do
    before { visit edit_supporter_type_path(supporter_type) }

    describe 'page' do
      it { should have_selector('h1', text: 'Edit supporter type') }
    end

    describe 'with invalid information' do
      invalid_name = ''
      before  do
        fill_in 'Name', with: invalid_name
        click_button 'Edit supporter type'
      end
      it { should have_selector('div.alert-error') }
    end

    describe 'with valid information' do
      valid_name = 'Newtype'
      before  do
        fill_in 'Name', with: valid_name
        click_button 'Edit supporter type'
      end
      it { should have_selector('div.alert-success') }
      specify { expect(supporter_type.reload.name).to eq valid_name }
    end
  end
end
