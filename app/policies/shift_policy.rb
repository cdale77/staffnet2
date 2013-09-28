class ShiftPolicy < Struct.new(:user, :record)

  def new?

  end

  def create?

  end

  def show?

  end

  def index?

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