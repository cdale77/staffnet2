module CimCustProfileService

  def self.create(supporter_id, supporter_email)
    profile = Cim::Profile.new(supporter_id, supporter_email)
    begin
      profile.store
    rescue
      puts 'ERROR: Problem creating CIM profile: ' + profile.server_message
    end
    return profile.cim_id
  end

  def self.destroy

  end

end