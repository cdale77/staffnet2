class ResolveDuplicateRecordsService < ServiceBase 

  def initialize(payload)
    @payload = payload
    @primary_record_id = @payload["primary_record"].to_i
    
  end

  def perform 

    primary_record = Supporter.find(@primary_record_id)
    

    primary_attrs = remove_id_from_hash(primary_record_hash, @primary_record_id)
    
    

    
  end

  private

    def primary_record_hash
      # extract the primary fields from the payload by searching for the
      # primary id in the keys
      @payload.select { |k,v| key.include? @primary_record_id.to_s }
    end

    def remove_id_from_hash(attr_hash, id)
      # strip out the id from the primary attrs hash keys
      attr_hash.inject({}) do |hash, (k,v)|
         hash.merge(k.sub("#{id.to_s}_", "") => v) 
      end
    end
end