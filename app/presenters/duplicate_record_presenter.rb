class DuplicateRecordPresenter < PresenterBase 

  attr_reader :klass 
  attr_reader :first_record
  attr_reader :second_record

  def initialize(record)
    super 
    @klass = self.record_type_name.classify.constantize
    @first_record = find_record(first_record_id)
    @second_record = find_record(additional_record_ids.first.to_i)
  end


  private

    def find_record(id)
      @klass.find_by(id: id)
    end
end
