class EmployeePolicy < Struct.new(:user, :record)

  def new?
  #  user.role? :admin
  end

  def create?
  #  user.role? :admin
  end

  # kludgy way to deal with cases where user is nil (user comes from the current_user method in the controller)
  def show?
    if user
      user.role? :manager || user.record == record
    end
  end

  def index?
  #  user.role? :manager
  end

  def edit?
  #  user.role? :admin
  end

  def update?
  #  user.role? :admin
  end

  def destroy?
  #  user.role? :admin
  end
end