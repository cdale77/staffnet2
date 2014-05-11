require 'spec_helper'

describe "AuthenticationPages" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:employee) { FactoryGirl.create(:employee) }

  subject { page }

  describe 'sign in' do
    before { visit new_user_session_path }


    describe 'page' do
      it { should have_selector('h1', 'Sign in') }
    end
    describe 'function' do

      describe 'with invalid information' do
        before { click_button 'Sign in' }
        it { should have_selector('h1', 'Sign in') }
        it { should have_selector('div.alert', text: 'Invalid') }
      end

      describe 'with valid information' do
        before do
          fill_in 'Email',    with: user.email.upcase
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end
        it { should have_content('Staffnet') }
        it { should have_title('Staffnet:Home') }
        it { should have_selector('div.alert', text: 'Signed in successfully') }
        describe "after visiting another page" do
          before { click_link "Home" }
          it { should_not have_selector('div.alert') }
        end
      end
    end
  end
end