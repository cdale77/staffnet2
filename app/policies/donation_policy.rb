class DonationPolicy < Struct.new(:user, :record)

  def new?
    user.role? :manager
  end

  def create?
    user.role? :manager
  end

  def show?
    user.role? :staff
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
