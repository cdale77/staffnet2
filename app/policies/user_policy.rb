class UserPolicy < Struct.new(:user, :user)

  def new?
    user.role? :super_admin
  end

  def create?
    user.role? :super_admin
  end



end