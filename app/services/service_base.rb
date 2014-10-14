class ServiceBase
  attr_reader :success
  attr_reader :message

  def initialize(*args)
    @success = false
    @message = ""
  end
end