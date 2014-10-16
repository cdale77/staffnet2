class DonationPolicy < Struct.new(:user, :record)

  def new?
    user.role? :staff
  end

  def create?
    user.role? :staff
  end

  def show?
    user.role? :staff
  end

  def index?
    user.role? :staff
  end

  def edit?
    user.role? :staff
  end

  def update?
    user.role? :staff
  end

  def destroy?
    user.role? :staff
  end
end
