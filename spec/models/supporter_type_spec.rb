# == Schema Information
#
# Table name: supporter_types
#
#  id   :integer          not null, primary key
#  name :string(255)      default("")
#

require 'spec_helper'

describe SupporterType do

  let!(:supporter_type) { FactoryGirl.create(:supporter_type) }


  subject { supporter_type }

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
    it 'should report the correct number of supporters' do
      supporter_type.number_of_supporters.should eql 2
    end
  end
end
