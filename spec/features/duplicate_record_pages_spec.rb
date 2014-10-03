require "spec_helper" 
include Warden::Test::Helpers
include ActionView::Helpers::NumberHelper
Warden.test_mode!

describe 'DuplicateRecordPages' do 

  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:supporter) { FactoryGirl.create(:supporter, first_name: "Bob") }
  let!(:dupe) { FactoryGirl.create(:supporter, first_name: "Robert") }
  let!(:record) { DuplicateRecord.create!(record_type_name: "supporter",
                            first_record_id: supporter.id,
                            additional_record_ids: [dupe.id],
                            resolved: false) }

  ### AS ADMIN USER ###

  describe 'as admin user' do 

    before do
        visit new_user_session_path
        fill_in "Email",    with: admin.email
        fill_in "Password", with: admin.password
        click_button "Sign in"
      end

    after do
      logout(:admin)
    end

    describe 'new_batch' do 
      before { visit new_duplicate_batch_path }
      describe 'page' do 
        it { should have_title "Staffnet:New dupe batch" }
        it { should have_selector "h1", "New duplicate record batch" }
      end
    end

    describe '#index' do 
      before { visit duplicate_records_path }
      describe 'page' do 
        it { should have_title "Staffnet:Resolve duplicates" }
        it { should have_selector "h1", "Resolve duplicates" }
      end
      describe 'records' do 
        it 'should list each record' do 
          #expect(page).to have_content(supporter.first_name)
          #expect(page).to have_content(dupe.first_name)
        end
      end
    end
  end
end
