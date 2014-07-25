class PaymentPolicy < Struct.new(:user, :record)

  def new?
    user.role? :admin
  end

  def create?
    user.role? :admin
  end

  def show?
    user.role? :staff
  end

  def index?
    user.role? :staff
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