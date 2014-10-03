class ResolveDuplicateRecordsService < ServiceBase 

  def initialize(payload)
    @payload = payload
    
    
  end

  def perform 

    primary_record = Supporter.find(@payload["primary_record"].to_i)
    
    # extract the primary record fields from @payload. The remaining are the 
    # secondary fields. 

    
  end
end