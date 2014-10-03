class ResolveDuplicateRecordsService < ServiceBase 

  def initialize(payload)
    @payload = payload
    @primary_record_id = @payload["primary_record"].to_i
    
  end

  def perform 

    primary_record = Supporter.find(@primary_record_id)
    
    primary_attrs = clean_hash_keys(extract_primary_record_hash, 
                                    "#{@primary_record_id}_")

    replacement_attrs = get_replacement_values

    new_attrs = primary_attrs.merge(replacement_attrs)

  end

  private

    def extract_primary_record_hash
      # extract the primary fields from the payload by searching for the
      # primary id in the keys
      @payload.select { |k,v| k.include? @primary_record_id.to_s }
    end

    def clean_hash_keys(input_hash, to_remove)
      # strip out the id from the primary attrs hash keys
      input_hash.inject({}) do |hash, (k,v)|
         hash.merge(k.sub("#{to_remove}", "") => v) 
      end
    end

    def extract_selected_attributes 
      @payload.select do |k,v| 
        k.include?("_selected") && v != @primary_record_id.to_s
      end
    end

    def get_replacement_values
      selected_attributes = clean_hash_keys(extract_selected_attributes, 
                                            "_selected")
      selected_attributes.inject({}) do |hash, (k,v)|
        hash.merge(k => @payload["#{v}_#{k}"])
      end
    end
end