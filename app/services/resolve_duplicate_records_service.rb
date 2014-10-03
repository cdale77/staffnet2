class ResolveDuplicateRecordsService < ServiceBase 

  def initialize(payload)
    @payload = payload
    @primary_record = Supporter.find(@payload["primary_record"].to_i)
  end

  def perform 

    # first figure out if @primary_record is the first ("primary"), or the 
    # dupe record in the original setup 


  end
end