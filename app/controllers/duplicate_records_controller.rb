class DuplicateRecordsController < ApplicationController 

  include Pundit 
  after_filter :verify_authorized, except: :new_file
  skip_before_filter :verify_authenticity_token, only: :new_file

  def new_batch 
    @new_batch = DuplicateRecord.new # just making an object for Pundit
    authorize @new_batch
  end

  def new_file 
    if CreateDuplicateRecordsJob.perform_later(params[:filepath])
      flash[:success] = "Dupe file imported."
    else
      flash[:danger] = "Something went wrong, please try again."
    end
    redirect_to root_path
  end

  def index
    duplicates = DuplicateRecord.unresolved 
    @record_presenters = DuplicateRecordPresenter.wrap(duplicates).paginate(page: params[:page], per_page: 5)
    authorize duplicates
  end

  def resolve 
    @duplicate_record = DuplicateRecord.find(params[:id]) 
    authorize @duplicate_record
    ResolveDuplicateRecordsJob.perform_later(params)
    respond_to do |format|
      format.js
    end
  end
end
