require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'TaskTypePages' do 
  
  subject { page }
  
  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:task_type) { FactoryGirl.create(:task_type) }
  
  ## HELPERS

  def fill_in_example_task_type
    fill_in 'Task type name',     with: 'Sample task type'
    fill_in 'Description',        with: 'Description'
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

    describe 'new task type' do

      before { visit new_task_type_path(task_type) }

      describe 'page' do
        it { should have_selector('h1', 'New task type') }
      end

      describe 'with invalid information' do
        it 'should not create a new task type' do
          expect { click_button 'New task type' }.not_to change(TaskType, :count)
        end
        describe 'after clicking' do
          before { click_button 'New task type' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_task_type }

        it 'should create a new task_type' do
          expect { click_button 'New task type' }.to change(TaskType, :count).by(1)
        end
        describe 'after saving task type' do
          before { click_button 'New task type' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'index' do
      before do
        5.times { FactoryGirl.create(:task_type) }
        visit task_types_path
      end

      after { TaskType.delete_all }

      describe 'page' do
        it { should have_title('All task types') }

        it 'should list each task type' do
          TaskType.all.each do |task_type|
            expect(page).to have_content(task_type.name)
          end
        end
        it 'should have edit and destroy links for task type' do
          TaskType.all.each do |task_type|
            expect(page).to have_link('edit', task_type_path(task_type))
            expect(page).to have_link('delete', task_type_path(task_type))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_task_type_path(task_type) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit task type') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Task type name', with: ''
          click_button 'Edit task type'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        let(:new_name)  { 'New task type' }
        before do
          fill_in 'name',       with: new_name
          click_button 'Edit task type'

          it { should have_selector('div.alert.alert-success') }
          specify { expect(task_type.reload.name).to  eq new_name }
        end
      end
    end

    describe 'destroy' do
      before { visit task_type_path(task_type) }
      it 'should destroy a task type' do
        expect { click_link 'delete' }.to change(TaskType, :count).by(-1)
      end
    end

  end
end