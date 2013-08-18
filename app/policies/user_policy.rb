class UserPolicy < Struct.new(:user)

  def create?
    user.role? :admin
  end

end