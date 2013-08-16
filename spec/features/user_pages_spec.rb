require 'spec_helper'

describe "UserPages" do
=begin
  subject { page }
  let(:user) { FactoryGirl.create(:user) }


  #describe 'show' do
  #  before { visit user_path(user) }
  #  it { should have_content (user.first_name) }
  #  it { should have_content (user.last_name) }
  #end

  describe 'new user' do
    before { visit new_user_registration_path }
    it { should have_selector('h1', text: 'New user') }
    it { should have_title('Staffnet:New user') }

    describe 'with invalid information' do
      it 'should not create a new user' do
        expect { click_button 'New user' }.not_to change(User, :count)
      end
      describe 'after clicking' do
        before { click_button 'New user' }
        it { should have_content('error') }
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'First name',             with: 'Brad'
        fill_in 'Last name',              with: 'Johnson'
        fill_in 'Email',                  with: 'example@example.com'
        fill_in 'Password',               with: 'foobar7878'
        fill_in 'Confirmation',           with: 'foobar7878'
      end
      it 'should create a new user' do
        expect { click_button 'New user' }.to change(User, :count).by(1)
      end
      describe 'after saving user' do
        before { click_button 'New user' }
        let(:user) { User.find_by(email: 'example@example.com') }

        it { should have_title('Staffnet:Home') }
        it { should have_selector('div.alert') }
      end
    end
  end

  describe 'edit user' do
    before { visit edit_user_registration_path(user) }

    describe 'page' do
      it { should have_selector('h1', text: 'Edit user') }
      it { should have_content(user.first_name) }
    end
  end
=end
end