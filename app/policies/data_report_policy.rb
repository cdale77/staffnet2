class DataReportPolicy < Struct.new(:user, :record)

  def new?
    user.role? :admin
  end

  def create?
    user.role? :admin
  end

  def index?
    user.role? :admin
  end
end
