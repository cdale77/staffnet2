# == Schema Information
#
# Table name: sendy_lists
#
#  id                    :integer          not null, primary key
#  supporter_type_id     :integer
#  sendy_list_identifier :string           default("")
#  name                  :string           default("")
#  created_at            :datetime
#  updated_at            :datetime
#

require 'spec_helper'

describe SendyList do

  sendy_list_attributes = { supporter_type_id: 3, sendy_list_identifier: '232radsqwer145ef434p98y5', name: 'supporters' }

  let(:sendy_list) { FactoryGirl.create(:sendy_list) }

  ## ATTRIBUTES
  describe 'sendy list attribute tests' do
    sendy_list_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:supporter_type) }
  it { should respond_to(:supporters) }

  ## VALIDATIONS
  describe 'name validations' do
    it 'should require a list name' do
      sendy_list.name = ''
      sendy_list.should_not be_valid
    end
  end

  describe 'sendy list identifier validations' do
    it 'should require a sendy list identifier' do
      sendy_list.sendy_list_identifier = ''
      sendy_list.should_not be_valid
    end
  end

  ## WRITERS
  describe 'name writer'do
    it 'should downcase list names' do
      sendy_list.name = 'Supporters'
      sendy_list.name.should eql 'supporters'
    end
  end
end
