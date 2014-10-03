class ResolveDuplicateRecordsService < ServiceBase 

  ## This is half-abstracted. "Child record" referes to Donation, at this point.
  ## Would like to abstract this to work with any records. . . .

  def initialize(payload)
    @payload = payload
    @primary_record_id = @payload["primary_record"].to_i
    @secondary_record_id = "" #set when extract_selected_attributes is called
  end

  def perform 
    
    # gather up all the info, and modify the params hash so it can be passed
    # to active record
    primary_attrs = clean_hash_keys(extract_primary_record_hash, 
                                    "#{@primary_record_id}_")
    replacement_attrs = get_replacement_values
    new_attrs = primary_attrs.merge(replacement_attrs)

    primary_record = Supporter.find(@primary_record_id)

    # merge the records
    # delete the child records marked for deletion by the user
    delete_child_records

    # merge remaining child records
    merge_child_records

    # update the primary record
    primary_record.update_attributes(new_attrs)

  end

  private

    ## EXTRACT DATA FROM THE PARAMS HASH
    def extract_primary_record_hash
      # extract the primary fields from the payload by searching for the
      # primary id in the keys
      @payload.select { |k,v| k.include? @primary_record_id.to_s }
    end

    def extract_selected_attributes 
      attrs = @payload.select do |k,v| 
        k.include?("_selected") && v != @primary_record_id.to_s
      end

      # this grabs the secondary id, which we have easily because we just
      # extracted the cases where the secondary fields were selected by the user
      @secondary_record_id = attrs.first.last.to_i

      return attrs
    end

    def extract_child_dupe_ids
      pairs = @payload.select { |k,v| k.include? "child-dupe" }
      pairs.map { |k,v| v }
    end

    def find_secondary_record_id 

    end

    ## MODIFY THE HASHES
    def clean_hash_keys(input_hash, to_remove)
      # strip out the id from the primary attrs hash keys
      input_hash.inject({}) do |hash, (k,v)|
         hash.merge(k.sub("#{to_remove}", "") => v) 
      end
    end

    def get_replacement_values
      selected_attributes = clean_hash_keys(extract_selected_attributes, 
                                            "_selected")
      selected_attributes.inject({}) do |hash, (k,v)|
        hash.merge(k => @payload["#{v}_#{k}"])
      end
    end


    ## MERGING FUNCTIONS

    def delete_child_records
      extract_child_dupe_ids.each do |child_id|
        donation = Donation.find_by(id: child_id.to_i)
        donation.destroy if donation
      end
    end

    def merge_child_records 

    end
end