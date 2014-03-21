class SupporterService < ServiceBase

  attr_reader :cim_id

  def initialize(supporter_id, sendy_list_id, supporter_email = '', old_email = '', new_status = '')
    @message = ''
    @success = false
    @cim_id = ''
    @new_status = new_status
    @supporter_id = supporter_id
    @cim_profile = CimCustProfileService.new(@supporter_id, supporter_email)
    @sendy_update = SendyUpdateService.new(@supporter_id, sendy_list_id, supporter_email, old_email)
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
      @sendy_update.update(action)
    end

    def update_record
      supporter = Supporter.find(@supporter_id)
      supporter.cim_id = @cim_id
      supporter.save
    end
end