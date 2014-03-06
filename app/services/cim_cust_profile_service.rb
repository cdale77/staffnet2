class CimCustProfileService < ServiceBase

  attr_reader :cim_id

  def initialize(supporter_id, supporter_email = '')
    @success = false
    @message = ''
    @supporter_id = supporter_id
    @supporter_email = supporer_email
    @cim_id = ''
  end

  def create
    profile = Cim::Profile.new(@supporter_id, @supporter_email)
    begin
      profile.store
    rescue
      @message = 'ERROR: Problem creating CIM profile: ' + profile.server_message
    end

  end

  def self.destroy

  end

end