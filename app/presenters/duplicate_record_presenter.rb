class DuplicateRecordPresenter < PresenterBase 


  def primary_record 
    klass = self.record_type.classify.constantize
    primary_record = klass.find(primary_record_id)
  end

end
