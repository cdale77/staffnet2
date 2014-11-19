class QueueSendyUpdateService < ServiceBase
  # Queues a Sendy update by creating a SendyUpdate database record. Note
  # sendy_status is stored as a string that matches the action: "subscribe",
  # "unsubscribe", "bounce", etc. The view layer handles presenting this to the
  # user.

  attr_accessor :sendy_list_id

  def initialize(supporter_id:, sendy_list_id:, supporter_email:, old_email: "")
    super
    @supporter_id = supporter_id
    @sendy_list_id = sendy_list_id
    @supporter_email = supporter_email
    @old_email = old_email
  end

  def update(action)
    @success = true if queue_sendy_update(action)
  end


  private
    def queue_sendy_update(action)
      SendyUpdate.create(
        supporter_id:     @supporter_id,
        sendy_list_id:    @sendy_list_id,
        sendy_email:      (@old_email.present? ? @old_email : @supporter_email),
        new_sendy_email:  (@old_email.present? ? @supporer_email : ""),
        action:           action,
        new_sendy_status: "#{action}")
    end
end

