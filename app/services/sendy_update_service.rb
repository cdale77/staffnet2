class SendyUpdateService < ServiceBase

  def initialize(supporter_id, supporter_email, sendy_list_id)
    @success = false
    @message = ''
    @supporter_id = supporter_id
    @sendy_list_id = sendy_list_id
    @supporter_email = supporter_email

  end

  def subscribe
    queue_sendy_update('subscribe', @supporter_email)
  end

  def unsubscribe
    queue_sendy_update('unsubscribe', @supporter_email)
  end

  private
    def queue_sendy_update(action, new_email, old_email = '')
      SendyUpdate.create( supporter_id:     @supporter_id,
                          sendy_list_id:    @sendy_list_id,
                          sendy_email:      (old_email.present? ? old_email : new_email),
                          new_sendy_email:  (old_email.present? ? new_email : ''),
                          action:           action)
    end
end