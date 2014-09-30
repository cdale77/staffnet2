class DuplicateRecordsController < ApplicationController 

  include Pundit 
  after_filter :verify_authorized 

  def new_batch 
    @new_batch = DuplicateRecord.new # just making an object for Pundit
    authorize @new_batch
  end
end
