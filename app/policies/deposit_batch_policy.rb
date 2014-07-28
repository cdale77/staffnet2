class DepositBatchPolicy < Struct.new(:user, :record)

  def review?
    user.role? :admin
  end


end