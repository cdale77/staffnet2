# == Schema Information
#
# Table name: task_types
#
#  id   :integer          not null, primary key
#  name :string(255)      default("")
#  desc :string(255)      default("")
#

require 'spec_helper'

describe TaskType do

  task_type_attributes = { name: 'Meeting', desc: 'Meetings' }

  let(:task_type) { FactoryGirl.create(:task_type) }

  subject { task_type }

  ## ATTRIBUTES
  describe 'task_type attribute tests' do
    task_type_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:tasks) }

  ## VALIDATIONS

  describe 'name validations' do
    it 'should reject task types with no name' do
      task_type.name = ''
      task_type.should_not be_valid
    end
  end
end
