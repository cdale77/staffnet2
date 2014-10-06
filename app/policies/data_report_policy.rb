class DataReportPolicy < Struct.new(:user, :record)

  def new?
    user.role? :admin
  end

end
