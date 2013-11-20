# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  name       :string(255)      default("")
#  start_date :date
#  end_date   :date
#  desc       :string(255)      default("")
#  notes      :text             default("")
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Project do

  project_attributes = {  name: 'Site migration', start_date: '2013-01-23', end_date: '2013-09-01',
                          desc: 'Migrate client web site to new platform.', notes: 'Notes go here.' }

  let(:project) { FactoryGirl.create(:project) }

  subject { project }

  ## ATTRIBUTES
  describe 'project attribute tests' do
    project_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:client) }

  ## VALIDATIONS
  describe 'name validations' do
    it 'should reject projects with no name' do
      project.name = ''
      project.should_not be_valid
    end
  end
end
