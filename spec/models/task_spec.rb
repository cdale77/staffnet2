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


end
