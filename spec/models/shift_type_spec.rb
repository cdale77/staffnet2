# == Schema Information
#
# Table name: shift_types
#
#  id                      :integer          not null, primary key
#  name                    :string           default("")
#  monthly_cc_multiplier   :decimal(8, 2)    default("0.0")
#  quarterly_cc_multiplier :decimal(8, 2)    default("0.0")
#  created_at              :datetime
#  updated_at              :datetime
#  fundraising_shift       :boolean          default("false")
#  quota_shift             :boolean          default("true")
#  workers_comp_type       :string           default("")
#

require 'spec_helper'

describe ShiftType do

  let(:shift_type) { FactoryGirl.create(:shift_type) }

  subject { shift_type }

  ## ATTRIBUTES
  it { should respond_to(:name) }
  it { should respond_to(:fundraising_shift) }
  it { should respond_to(:quota_shift) }
  it { should respond_to(:monthly_cc_multiplier) }
  it { should respond_to(:quarterly_cc_multiplier) }
  it { should respond_to(:workers_comp_type) }

  ## RELATIONSHIPS
  it { should respond_to(:shifts) }
end
