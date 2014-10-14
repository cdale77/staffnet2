class CimCustProfileService < ServiceBase

  # Responsible for creating AuthorizeNet CIM customer profiles. To account for
  # database migration in 2014, 20000 will be added to the Supporter ID and used
  # for the cim customer id field, to avoid collision with legacy ids.
  # This new value will be stored in the database for
  # reference.

  attr_reader :cim_id

  def initialize(cim_customer_id:, supporter_email:, supporter_cim_id: "")
    @success = false
    @message = ""
    @cim_customer_id = cim_customer_id
    @supporter_email = supporter_email
    @cim_id = supporter_cim_id
  end

  def create
    profile = Cim::Profile.new(@cim_customer_id, @supporter_email)
    begin
      profile.store
    rescue
      @message = "Problem creating CIM profile: #{profile.server_message}"
    end
    transfer_messages(profile)
    puts @message
  end

  def destroy
    # need to supply the cim profile id when destroying a profile
    profile = Cim::Profile.new(@cim_customer_id, '', @cim_id)
    begin
      profile.unstore
    rescue
      @message = "Problem unstoring CIM profile: #{profile.server_message}"
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
