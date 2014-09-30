require "spec_helper" 

describe DuplicateRecordPolicy do 

  subject { DuplicateRecordPolicy.new(user, duplicate_record) }

  context 'for a regular user' do 
    let(:user) { FactoryGirl.create(:user) }

    it { should_not permit(:new_batch) }
  end

end
