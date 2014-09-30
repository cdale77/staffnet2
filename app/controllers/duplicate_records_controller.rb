class DuplicateRecordsController < ApplicationController 

  include Pundit 
  after_filter :verify_authorized, except: :new_file
  skip_before_filter :verify_authenticity_token, only: :new_file

  def new_batch 
    @new_batch = DuplicateRecord.new # just making an object for Pundit
    authorize @new_batch
  end

  def new_file 
    file_url = params[:report][:url]
    puts "this is what I got: #{file_url}"
    render nothing: true
  end
end
