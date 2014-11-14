class DepositBatchPolicy < Struct.new(:user, :record)

  def show?
    user.role? :admin
  end

  def index?
    user.role? :admin
  end

  def edit?
    user.role? :admin
  end

  def update?
    user.role? :admin
  end

  def process_batch?
    user.role? :admin
  end
end
