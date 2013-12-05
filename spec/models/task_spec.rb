# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  shift_id   :integer
#  project_id :integer
#  name       :string(255)      default("")
#  hours      :decimal(8, 2)    default(0.0)
#  desc       :string(255)      default("")
#  notes      :text             default("")
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Task do

  task_attributes = { name: 'Some task', hours: '2', desc: 'Some description', notes: 'Notes go here' }

  let(:task) { FactoryGirl.create(:task) }

  subject { task }

  ## ATTRIBUTES
  describe 'task attribute tests' do
    task_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:shift) }
  it { should respond_to(:project) }
  it { should respond_to(:task_type) }

  ## VALIDATIONS
  describe 'name validations' do
    it 'should reject tasks with no name' do
      task.name = ''
      task.should_not be_valid
    end
  end

  describe 'hours validations' do
    it 'should require a value for hours' do
      task.hours = 0
      task.should_not be_valid
    end
    it 'should require hours to be a decimal or integer' do
      task.hours = 'asdfas'
      task.should_not be_valid
    end
    it 'should require task hours to be less than or equal to 24' do
      task.hours = 24.1
      task.should_not be_valid
    end
  end

end
