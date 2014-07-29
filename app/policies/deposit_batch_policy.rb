class DepositBatchPolicy < Struct.new(:user, :record)

  def show?
    user.role? :admin
  end

  def index?
    user.role? :admin
  end
end
