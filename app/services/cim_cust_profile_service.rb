class CimCustProfileService < ServiceBase

  attr_reader :cim_id

  def initialize(supporter_id, supporter_email, supporter_cim_id = '')
    @success = false
    @message = ''
    @supporter_id = supporter_id
    @supporter_email = supporter_email
    @cim_id = supporter_cim_id
  end

  def create
    profile = Cim::Profile.new(@supporter_id, @supporter_email)
    begin
      profile.store
    rescue
      @message = "ERROR: Problem creating CIM profile: #{profile.server_message}"
    end
    transfer_messages(profile)
    puts @message
  end

  def destroy
    # need to supply the cim profile id when destroying a profile
    profile = Cim::Profile.new(@supporter_id, '', @cim_id)
    begin
      profile.unstore
    rescue
      @message = "ERROR: Problem unstoring CIM profile: #{profile.server_message}"
    end
    transfer_messages(profile)
    puts @message
  end

  private
    def transfer_messages(profile_object)
      @success = profile_object.success
      @message = profile_object.server_message
      @cim_id = profile_object.cim_id
    end

end