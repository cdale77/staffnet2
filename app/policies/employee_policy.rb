class EmployeePolicy < Struct.new(:user, :record)

  def new?
    user.role? :admin
  end

  def create?
    user.role? :admin
  end

  def show?
    user.role? :manager or user == record.user
  end

  def index?
    user.role? :manager
  end

  def edit?
    user.role? :admin
  end

  def update?
    user.role? :admin
  end

  def destroy?
    user.role? :admin
  end
end