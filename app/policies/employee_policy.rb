class EmployeePolicy < Struct.new(:user, :employee)

  def new?
    user.role? :admin
  end

  def create?
    user.role? :admin
  end

  def show?
    user.role? :admin# or user == employee.user
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