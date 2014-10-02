require "spec_helper" 
include Warden::Test::Helpers
include ActionView::Helpers::NumberHelper
Warden.test_mode!

describe 'DuplicateRecordPages' do 

  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }

  def create_duplicate_records 
    5.times { FactoryGirl.create(:supporter) }
    supporters = Supporter.all 
    primary_record = supporters.first
    dupe_id_array = supporters.map { |s| s.id }
    DuplicateRecord.create!(record_type_name: "supporter",
                            primary_record_id: primary_record.id,
                            duplicate_record_ids: dupe_id_array)
  end

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
      before do 
        create_duplicate_records
        visit duplicate_records_path
      end
      describe 'page' do 
        it { should have_title "Staffnet:Resolve duplicates" }
        it { should have_selector "h1", "Resolve duplicates" }
      end
    end
  end
end
