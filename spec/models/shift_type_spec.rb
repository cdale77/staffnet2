# == Schema Information
#
# Table name: shift_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("")
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe ShiftType do

  let(:shift_type) { FactoryGirl.create(:shift_type) }

  subject { shift_type }

  ## ATTRIBUTES
  it { should respond_to(:name) }

  ## RELATIONSHIPS
  it { should respond_to(:shifts) }

end
