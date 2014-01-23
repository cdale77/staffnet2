# spec/features/external_request_spec.rb
#require 'spec_helper'


#describe 'External request' do

#  let(:supporter) { FactoryGirl.create(:supporter) }

#  it 'queries FactoryGirl contributors on Github' do
#    profile = Cim::Profile.new(supporter.id, supporter.email_1)
#    response = profile.store
#    expect(response).to be_an_instance_of HTTParty::Response 
#  end
#end