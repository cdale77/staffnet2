class SupporterService < ServiceBase

  attr_reader :cim_id

  def initialize(supporter, sendy_list_id, old_email = "", new_status = "",
                 cim_id = "")
    @supporter = supporter
    @message = ''
    @success = false
    @cim_id = cim_id
    @new_status = new_status
    @cim_profile = CimCustProfileService.new(@supporter.cim_customer_id,
                                             @supporter.email_1,
                                             @cim_id)
    @sendy_update = SendyUpdateService.new(@supporter.id,
                                           sendy_list_id,
                                           @supporter.email_1,
                                           old_email)
  end

  def new_supporter
    if store_cim_profile && queue_sendy_update('subscribe') && update_record
      @success = true
    end
  end

  def destroy_supporter
    if unstore_cim_profile && queue_sendy_update('unsubscribe')
      @success = true
    end
  end

  def update_supporter
    if queue_sendy_update(@new_status)
      @success = true
    end
  end


  private
    def store_cim_profile
      @cim_profile.create
      cim_profile_result
    end

    def unstore_cim_profile
      @cim_profile.destroy
      cim_profile_result
    end

    def cim_profile_result
      @cim_id = @cim_profile.cim_id
      @message = "#{@message} : AuthNet: #{@cim_profile.message}"
      @cim_profile.success
    end

    def queue_sendy_update(action)
      # hacky way to not queue a Sendy update if there's no email address
      if @supporter.email_1.blank?
        true
      else
        @sendy_update.update(action)
      end
    end

    def update_record
      @supporter.cim_id = @cim_id
      @supporter.sendy_list_id = @sendy_update.sendy_list_id
      @supporter.save
    end
end