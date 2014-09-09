# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Tag do
  it { should respond_to(:name) }
  it { should respond_to(:taggings) }
  it { should respond_to(:supporters) }
end
