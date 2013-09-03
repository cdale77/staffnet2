require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ShiftTypePages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:manager) { FactoryGirl.create(:manager) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:user) { FactoryGirl.create(:user) }


  ## HELPERS ##

  def create_sample_shift_types
    FactoryGirl.create(:shift_type, shift_type: 'door')
    FactoryGirl.create(:shift_type, shift_type: 'office')
    FactoryGirl.create(:shift_type, shift_type: 'vacation')
    FactoryGirl.create(:shift_type, shift_type: 'sick')
  end

  ## AS SUPERADMIN USER ##
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

    describe 'new shift type' do
      before { visit new_shift_type_path }

      describe 'page' do
        it { should have_selector('h1', text: 'New shift type') }
      end

      describe 'with invalid information' do
        it 'should not create a shift_type' do
          expect { click_button 'New shift type' }.not_to change(ShiftType, :count)
        end
        describe 'after clicking' do
          before { click_button 'New shift type' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in 'Shift type', with: 'Tabling' }

        it 'should create a new shift_type' do
          expect { click_button 'New shift type' }.to change(ShiftType, :count).by(1)
        end
        describe 'after saving shift type' do
          before { click_button 'New shift type' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        create_sample_shift_types
        visit shift_types_path
      end

      after { ShiftType.delete_all }

      describe 'page' do
        it { should have_selector('h1', text: 'Shift types') }

        it 'should list each shift type' do
          ShiftType.all.each do |shift_type|
            expect(page).to have_content(shift_type.shift_type)
          end
        end

        it 'should have edit and delete links for each shift type' do
          ShiftType.all.each do |shift_type|
            expect(page).to have_link('edit', edit_shift_type_path(shift_type))
            expect(page).to have_link('delete', shift_type_path(shift_type))
          end
        end
      end

    end
  end


end