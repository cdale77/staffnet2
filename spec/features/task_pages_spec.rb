=begin
require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'TaskPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let(:staff) { FactoryGirl.create(:staff) }
  let(:project) { FactoryGirl.create(:project) }
  let(:project2) { FactoryGirl.create(:project) }
  let!(:shift) { FactoryGirl.create(:shift) }
  let!(:task) { FactoryGirl.create(:task, project_id: project.id) }

  ## HELPERS

  def fill_in_example_task
    fill_in 'Task name',         with: 'Sample task'
    select project.name,    from: 'task_project_id'
    fill_in 'Hours',        with: 2.25
    fill_in 'Description',  with: 'Description'
    fill_in 'Notes',        with: 'Notes'
  end

  def create_sample_tasks
    FactoryGirl.create(:task, name: 'Sample Task 1')
    FactoryGirl.create(:task, name: 'Sample Task 2')
    FactoryGirl.create(:task, name: 'Sample Task 3', project_id: project2.id)
    FactoryGirl.create(:task, name: 'Sample Task 4', project_id: project2.id)
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

    describe 'new task' do

      # new tasks are only made through the shift association
      before { visit new_shift_task_path(shift) }

      describe 'page' do
        it { should have_selector('h1', 'New task') }
      end

      describe 'with invalid information' do
        it 'should not create a new task' do
          expect { click_button 'New task' }.not_to change(Task, :count)
        end
        describe 'after clicking' do
          before { click_button 'New task' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_task }

        it 'should create a new task' do
          expect { click_button 'New task' }.to change(Task, :count).by(1)
        end
        describe 'after saving task' do
          before { click_button 'New task' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      describe 'page' do
        before { visit task_path(task) }
        describe 'page' do
          it { should have_content (task.name) }
          describe 'links' do
            it { should have_link('edit', href: edit_task_path(task)) }
            it { should have_link('delete', href: task_path(task)) }
          end
        end
      end
    end

    describe 'index' do
      before do
        create_sample_tasks
        visit tasks_path
      end

      after { Task.delete_all }

      describe 'page' do
        it { should have_title('All tasks') }

        it 'should list each task with project name' do
          Task.all.each do |task|
            expect(page).to have_content(task.name)
            expect(page).to have_content(task.project.name)
          end
        end
        it 'should have show and edit links for tasks' do
          Task.all.each do |task|
            expect(page).to have_link('details', task_path(task))
            expect(page).to have_link('edit', task_path(task))
          end
        end
      end
    end

    describe 'edit' do
      before { visit edit_task_path(task) }

      describe 'page' do
        it { should have_selector('h1', text: 'Edit task') }
      end

      describe 'with invalid information' do
        before do
          fill_in 'Task name', with: ''
          click_button 'Edit task'
        end
        it { should have_selector('div.alert-error') }
      end

      describe 'with valid information' do
        let(:new_name)  { 'New task' }
        before do
          fill_in 'name',       with: new_name
          click_button 'Edit task'

          it { should have_selector('div.alert.alert-success') }
          specify { expect(task.reload.name).to  eq new_name }
        end
      end
    end

    describe 'destroy' do
      before { visit task_path(task) }
      it 'should destroy a task' do
        expect { click_link 'delete' }.to change(Task, :count).by(-1)
      end
    end

  end

#### AS STAFF USER ####

# staff users should not see edit or delete links on tasks, except their own
  describe 'as staff user' do
    before do
      visit new_user_session_path
      fill_in 'Email',    with: staff.email
      fill_in 'Password', with: staff.password
      click_button 'Sign in'
    end

    after do
      logout(:staff)
    end

    let(:employee) { FactoryGirl.create(:employee, user_id: staff.id) }
    let(:shift) { FactoryGirl.create(:shift, employee_id: employee.id) }
    let(:self_task) { FactoryGirl.create(:task, shift_id: shift.id) }

    describe 'show' do
      describe 'their own task' do
        describe 'page' do
          before { visit task_path(self_task) }
          describe 'page' do
            describe 'links' do
              it { should have_link('edit', href: edit_task_path(self_task)) }
              it { should have_link('delete', href: task_path(self_task)) }
            end
          end
        end
      end
    end

    describe 'index' do
      before do
        create_sample_tasks
        visit tasks_path
      end

      after { Task.delete_all }

      describe 'page' do

        describe 'page' do
          it 'should show the correct users shifts' do
            expect(page).to have_content(staff_task._name)
            expect(page).to have_content(staff2_task._name)
          end
          it 'should not show shifts for another user' do
            expect(page).to_not have_content(admin_task.name)
          end
        end
      end
    end
  end
end
=end
