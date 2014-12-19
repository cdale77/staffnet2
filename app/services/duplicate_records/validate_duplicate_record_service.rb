class ValidateDuplicateRecordService < ServiceBase

  def initialize(duplicate_record)
    @duplicate_record = duplicate_record
    super
  end

  def valid?
    if @duplicate_record.first_record_id.blank?
      return false
    elsif @duplicate_record.additional_record_ids.empty?
      return false
    elsif !can_find_all_records?
      return false
    elsif @duplicate_record.additional_record_ids.include?(@duplicate_record.first_record_id)
      return false
    else
      return true
    end
  end

  private

    def can_find_all_records?
      id_array = []
      result = true
      id_array << @duplicate_record.first_record_id
      @duplicate_record.additional_record_ids.each { |id| id_array << id }
      id_array.each do |id|
        begin
          Supporter.find(id.to_i)
        rescue
          result = false
        end
      end
      return result
    end
end

