class SupporterService < ServiceBase

  attr_reader :cim_id

  def initialize( supporter:,
                  sendy_list_id:,
                  old_email: "",
                  new_status: "",
                  cim_id: "")
    super
    @supporter = supporter
    @cim_id = cim_id
    @new_status = new_status
    @cim_profile_service = CimCustProfileService.new(
                              cim_customer_id:  @supporter.cim_customer_id,
                              supporter_email:  @supporter.email_1,
                              supporter_cim_id: @cim_id)
    @sendy_update = QueueSendyUpdateService.new(
                              supporter_id:     @supporter.id,
                              sendy_list_id:    sendy_list_id,
                              supporter_email:  @supporter.email_1,
                              old_email:        old_email)
  end

  def new_supporter
    if store_cim_profile && queue_sendy_update("subscribe") && update_record
      @success = true
    end
  end

  def destroy_supporter
    if unstore_cim_profile && queue_sendy_update("unsubscribe")
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
      @cim_profile_service.create
      cim_profile_result
    end

    def unstore_cim_profile
      @cim_profile_service.destroy
      cim_profile_result
    end

    def cim_profile_result
      @cim_id = @cim_profile_service.cim_id
      @message = "#{@message} : AuthNet: #{@cim_profile_service.message}"
      @cim_profile_service.success
    end

    def queue_sendy_update(action)
      #only queue an update if the supporter can get email
      if @supporter.email_1.present? &&
         !@supporter.email_1_bad ? &&
         !@supporter.do_not_email
        @sendy_update.update(action)
      else
        return true
      end
    end

    def update_record
      @supporter.cim_id = @cim_id
      @supporter.sendy_list_id = @sendy_update.sendy_list_id
      @supporter.sendy_status = "pending"
      @supporter.save
    end
end

