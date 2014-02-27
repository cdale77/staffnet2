# == Schema Information
#
# Table name: sendy_lists
#
#  id                    :integer          not null, primary key
#  supporter_type_id     :integer
#  sendy_list_identifier :string(255)      default("")
#  name                  :string(255)      default("")
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
end
