# == Schema Information
#
# Table name: duplicate_records
#
#  id                   :integer          not null, primary key
#  record_type          :string           default("")
#  primary_record_id    :integer
#  duplicate_record_ids :string           default("{}"), is an Array
#  created_at           :datetime
#  updated_at           :datetime
#

require "spec_helper"

describe DuplicateRecord do 

  duplicate_record_attributes = SpecData.duplicate_record_attributes

  let!(:duplicate_record) { DuplicateRecord.create(duplicate_record_attributes) }

  subject { duplicate_record }

    ## ATTRIBUTES
  describe 'attribute tests' do
    duplicate_record_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end
end
