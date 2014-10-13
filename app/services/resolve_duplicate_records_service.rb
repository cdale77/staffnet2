class ResolveDuplicateRecordsService < ServiceBase 

  ## This is half-abstracted. "Child record" referes to Donation, at this point.
  ## Would like to abstract this to work with any records. . . .

  def initialize(payload)
    @payload = payload
    @duplicate_record = DuplicateRecord.find_by id: @payload["id"].to_i
    @primary_record_id = @payload["primary_record"].to_i
    @secondary_record_id = get_secondary_record_id
  end

  def perform 
    
    # gather up all the info, and modify the params hash so it can be passed
    # to active record
    primary_attrs = clean_hash_keys(extract_primary_record_hash, 
                                    "#{@primary_record_id}_")
    # remove the primary key from primary_attrs
    primary_attrs.delete("id")

    replacement_attrs = get_replacement_values
    new_attrs = primary_attrs.merge(replacement_attrs)

    ## look up the records
    primary_record = Supporter.find(@primary_record_id)
    secondary_record = Supporter.find(@secondary_record_id)

    # merge the records
    if primary_record && secondary_record 
      
      # delete the child records marked for deletion by the user
      delete_child_records

      # merge remaining child records
      merge_child_records(secondary_record)

      # update the primary record
      primary_record.update_attributes(new_attrs)

      ## if we merged any credit donations, update the notes
      if secondary_record.donations.where(donation_type: "credit").any?
        primary_record.notes = "Dupe cim id: #{secondary_record.cim_id}"
        primary_record.save
      end

      # remove the cim profile associated with the old record
      cim_service = CimCustProfileService.new(secondary_record.cim_customer_id,
                                              secondary_record.email_1,
                                              secondary_record.cim_id)
      cim_service.destroy

      # destroy the old record. Reload it first so as not to destroy the
      # child records that were just moved
      secondary_record.reload.destroy

      # if there are still more dupes, then create a new record
      @duplicate_record.additional_record_ids.delete(@secondary_record_id.to_s)
      if @duplicate_record.additional_record_ids.any? 
        DuplicateRecord.create!(
          first_record_id: @primary_record_id,
          additional_record_ids: @duplicate_record.additional_record_ids,
          record_type_name: "supporter")
      end

      # finally mark the record as resolved. 
      @duplicate_record.update_attributes(resolved: true)
    end
  end

  private

    ## EXTRACT DATA FROM THE PARAMS HASH
    def extract_primary_record_hash
      # extract the primary fields from the payload by searching for the
      # primary id in the keys
      @payload.select { |k,v| k.include? @primary_record_id.to_s }
    end

    def extract_selected_attributes 
      @payload.select do |k,v| 
        k.include?("_selected") && v != @primary_record_id.to_s
      end
    end

    def extract_child_dupe_ids
      pairs = @payload.select { |k,v| k.include? "child-dupe" }
      pairs.map { |k,v| v }
    end

    ## MODIFY THE HASHES
    def clean_hash_keys(input_hash, to_remove)
      # strip out the id from the primary attrs hash keys
      input_hash.inject({}) do |hash, (k,v)|
         hash.merge(k.sub(to_remove, "") => v) 
      end
    end

    def get_replacement_values
      selected_attributes = clean_hash_keys(extract_selected_attributes, 
                                            "_selected")
      selected_attributes.inject({}) do |hash, (k,v)|
        hash.merge(k => @payload["#{v}_#{k}"])
      end
    end

    def get_secondary_record_id 
      id_array = @payload.map { |k,v| k[/\A\d+/] }

      #strip out the nils
      id_array.delete nil 

      ids = id_array.uniq

      ids.select {|id| id != @primary_record_id.to_s }.first.to_i
    end


    ## MERGING FUNCTIONS

    def delete_child_records
      extract_child_dupe_ids.each do |child_id|
        donation = Donation.find_by(id: child_id.to_i)
        donation.destroy if donation
      end
    end

    def merge_child_records(secondary_record) 

      #merge donations
      secondary_record.donations.each do |d|
        d.update_attributes supporter_id: @primary_record_id
      end

      # merge payment profiles
      secondary_record.payment_profiles.each do |pp|
        pp.update_attributes supporter_id: @primary_record_id
      end

      # merge taggings
      secondary_record.taggings.each do |t|
        t.update_attributes supporter_id: @primary_record_id
      end
    end
end