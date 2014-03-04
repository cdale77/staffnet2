module CreateSendyUpdateRecord

  ## This module wraps a few methods that add the appropriate record to the SendyList table for later updating.

  def self.subscribe(supporter_id)
    queue_sendy_update('subscribe', supporter_id)
  end

  def self.unsubscribe(supporter_id)
    queue_sendy_update('unsubscribe', supporter_id)
  end

  def self.update(supporter_id, action, old_email = '')
    queue_sendy_update(action, supporter_id, old_email)
  end


  private

    def self.queue_sendy_update(action, supporter_id, old_email = '')
      supporter = find_supporter(supporter_id)
      if supporter && create_sendy_update_record(supporter_id, supporter.sendy_list_id, action, supporter.email_1,
                                                 old_email)
        return true
      else
        return false
      end
    end

    def self.find_supporter(supporter_id)
      begin
        Supporter.find(supporter_id)
      rescue
        return false
      end
    end


    # in the case of updating an email address, new_sendy_email should not be blank. Otherwise it should be blank
    def self.create_sendy_update_record(supporter_id, sendy_list_id, action, new_email, old_email)
      begin
        SendyUpdate.create( supporter_id:     supporter_id,
                            sendy_list_id:    sendy_list_id,
                            sendy_email:      (old_email.present? ? old_email : new_email),
                            new_sendy_email:  (old_email.present? ? new_email : ''),
                            action:           action)
      rescue
        return false
      end
    end



end