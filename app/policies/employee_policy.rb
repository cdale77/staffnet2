class EmployeePolicy < Struct.new(:user, :record)

  def new?
 #   user.role? :admin
  end

  def create?
 #   user.role? :admin
  end


  def show?
    if user # kludge. sometimes current_user is nil
      user.role? :manager or record.is_owned_by?(user)
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