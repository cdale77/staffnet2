class DuplicateRecordsController < ApplicationController 

  include Pundit 
  after_filter :verify_authorized 

  def new_batch 
  end
end