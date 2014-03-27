# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  tag_id       :integer
#  supporter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Tagging do
  it { should respond_to(:tag) }
  it { should respond_to(:article) }
end
