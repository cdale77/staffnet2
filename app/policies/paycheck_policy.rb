class PaycheckPolicy < Struct.new(:user, :record)

  def show?
    user.role? :admin or user == record.user
  end
end
