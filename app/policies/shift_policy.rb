class ShiftPolicy < Struct.new(:user, :record)

  def new?
    user.role? :manager or user == record.user
  end

  def create?
    user.role? :manager or user == record.user
  end

  def show?
    user.role? :manager or user == record.user
  end

  def index?
    user.role? :staff
  end

  def edit?
    user.role? :manager
  end

  def update?
    user.role? :manager
  end

  def destroy?
    user.role? :manager
  end

end