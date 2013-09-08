require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ShiftPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }

  let!(:employee) { FactoryGirl.create(:employee, first_name: 'Jason') }

  let!(:shift) { FactoryGirl.create(:shift) }

  ## HELPERS

  def fill_in_example_shift
    select employee.full_name,    from: 'shift_employee_id'
    fill_in 'Date',               with: '13-09-4'
    fill_in 'Time in',            with: '09:00 AM'
    fill_in 'Time out',           with: '05:00 PM'
  end


  ## AS SUPERADMIN USER
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

    describe 'new shift' do
      before { visit new_shift_path }

      describe 'page' do
        it { should have_selector('h1', 'New shift') }

      end

      describe 'with invalid information' do
        it 'should not create a new shift' do
          expect { click_button 'New shift' }.not_to change(Shift, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_shift }

        it 'should create a new shift' do
          expect { click_button 'New shift' }.to change(Shift, :count).by(1)
        end
        describe 'after saving shift' do
          before { click_button 'New shift' }

          it { should have_selector('div.alert') }
        end
      end
    end
  end




end