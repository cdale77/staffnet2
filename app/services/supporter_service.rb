class SupporterService < ServiceBase

  attr_reader :cim_id

  def initialize(supporter_id, supporter_email = '')
    @message = ''
    @success = false
    @supporter_id = supporter_id
    @supporter_email = supporter_email
    @cim_id = ''
    @cim_profile = CimCustProfileService.new(@supporter_id, @supporter_email)
  end

  def new_supporter
    if store_cim_profile && update_record
      @success = true
    end
  end

  def destroy
    if unstore_cim_profile
      @success = true
    end
  end


  private
    def store_cim_profile
      @cim_profile.create
      @cim_id = @cim_profile.cim_id
      @message = "#{@message} : #{@cim_profile.message}"
      @cim_profile.success
    end

    def unstore_cim_profile

    end

    def queue_sendy_update

    end

    def update_record
      supporter = Supporter.find(@supporter_id)
      supporter.cim_id = @cim_id
      supporter.save
    end

end