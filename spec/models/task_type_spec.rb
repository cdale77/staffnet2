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
end