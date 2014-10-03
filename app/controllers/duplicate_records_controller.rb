class DuplicateRecordsController < ApplicationController 

  include Pundit 
  after_filter :verify_authorized, except: :new_file
  skip_before_filter :verify_authenticity_token, only: :new_file

  def new_batch 
    @new_batch = DuplicateRecord.new # just making an object for Pundit
    authorize @new_batch
  end

  def new_file 
    CreateDuplicateRecordsJob.enqueue(params[:filepath])
    render nothing: true
  end

  def index
    duplicates = DuplicateRecord.unresolved 
    @record_presenters = DuplicateRecordPresenter.wrap(duplicates).paginate(page: params[:page], per_page: 5)
    authorize duplicates
  end

  def resolve 

  
  end
end
