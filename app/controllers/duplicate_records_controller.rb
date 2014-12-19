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

  def edit
    @dupe_count = DuplicateRecord.count
    duplicate_record = DuplicateRecord.first || DuplicateRecord.new
    authorize duplicate_record
    validation_service = ValidateDuplicateRecordService.new(duplicate_record)
    if @dupe_count > 0 && validation_service.valid?
      @presenter = DuplicateRecordPresenter.new(duplicate_record)
    else
      duplicate_record.destroy #destroy any records that are invalid
      flash[:danger] = "We have fixed a problem that occured. Please try again"
      redirect_to edit_duplicate_record_path
    end
  end

  def update
    duplicate_record = DuplicateRecord.find(params[:id])
    authorize duplicate_record
    if ResolveDuplicateRecordsService.new(payload: params).perform
      flash[:success] = "Merged records"
    else
      flash[:danger] = "Something went wrong"
    end
    redirect_to edit_duplicate_record_path
  end

  def destroy
    duplicate_record = DuplicateRecord.find(params[:id])
    authorize duplicate_record
    duplicate_record.destroy
    flash[:success] = "Marked as not a duplicate"
    redirect_to edit_duplicate_record_path
  end
end

