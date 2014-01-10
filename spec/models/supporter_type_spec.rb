# == Schema Information
#
# Table name: supporter_types
#
#  id                :integer          not null, primary key
#  name              :string(255)      default("")
#  created_at        :datetime
#  updated_at        :datetime
#  mailchimp_sync_at :datetime
#

require 'spec_helper'

describe SupporterType do

  let!(:supporter_type) { FactoryGirl.create(:supporter_type) }


  subject { supporter_type }

  ## HELPERS
  def create_records_for_mailchimp
    3.times { FactoryGirl.create(:supporter_type) }
    2.times { FactoryGirl.create(:supporter_type, mailchimp_sync_at: (Time.now + 24.hours)) }
  end

  ## ATTRIBUTES
  it { should respond_to(:name) }

  ## RELATIONSHIPS
  it { should respond_to(:supporters) }

  ## VALIDATIONS
  describe 'name valdiations' do
    it 'should require a name' do
      supporter_type.name = ''
      supporter_type.should_not be_valid
    end
  end

  ## METHODS

  describe 'number_of_supporters method' do
    before do
      2.times { FactoryGirl.create(:supporter, supporter_type_id: supporter_type.id) }
    end

    after { SupporterType.delete_all }

    it 'should report the correct number of supporters' do
      supporter_type.number_of_supporters.should eql 2
    end
  end

  ## MAILCHIMP
  describe 'MailChimp syncing' do
    before { create_records_for_mailchimp }
    after { SupporterType.delete_all }
    it 'should collect the right records for sync' do
      expect(SupporterType.mailchimp_records_to_sync.count).to eql 4
    end
  end

  describe 'MailChimp sync stamp' do
    it 'should set the sync stamp on create' do
      supporter_type.mailchimp_sync_at.should_not be_blank
    end
  end

end
