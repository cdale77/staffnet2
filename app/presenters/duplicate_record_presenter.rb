class DuplicateRecordPresenter < PresenterBase 

  attr_reader :klass 
  attr_reader :primary_record
  attr_reader :duplicate_record

  def initialize(record)
    super 
    @klass = self.record_type_name.classify.constantize
    @primary_record = find_record(primary_record_id)
    @duplicate_record = find_record(duplicate_record_ids.first.to_i)
  end


  private

    def find_record(id)
      @klass.find(id)
    end
end
