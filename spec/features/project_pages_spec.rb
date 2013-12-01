require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'ProjectPages' do

  subject { page }

  let(:super_admin) { FactoryGirl.create(:super_admin) }
  let!(:client) { FactoryGirl.create(:client) }
  let(:project) { FactoryGirl.create(:project) }

  ## HELPERS

  def fill_in_example_project
    select client.name,      from: 'project_client_id'
    fill_in 'Project name',          with: 'Sample project'
    fill_in 'Start date',    with: '2013-02-10'
    fill_in 'Description',   with: 'Sample project.'
    fill_in 'Notes',         with: 'Notes go here.'
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

    describe 'new project' do
      before { visit new_project_path }

      describe 'page' do
        it { should have_selector('h1', 'New project') }
      end

      describe 'with invalid information' do
        it 'should not create a new project' do
          expect { click_button 'New project' }.not_to change(Project, :count)
        end
        describe 'after clicking' do
          before { click_button 'New project' }
          it { should have_content('error') }
        end
      end

      describe 'with valid information' do
        before { fill_in_example_project }

        it 'should create a new project' do
          expect { click_button 'New project' }.to change(Project, :count).by(1)
        end
        describe 'after saving project' do
          before { click_button 'New project' }

          it { should have_selector('div.alert') }
        end
      end
    end

    describe 'show' do
      describe 'page' do
        before { visit project_path(project) }
        describe 'page' do
          it { should have_content (project.name) }
          describe 'links' do
            it { should have_link('edit', href: edit_project_path(project)) }
            it { should have_link('delete', href: project_path(project)) }
          end
        end
      end
    end
  end
end