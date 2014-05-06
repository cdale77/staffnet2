class PledgeEmailPolicy < Struct.new(:user, :record)

  def new?
    user.role? :manager
  end

  def create?
    user.role? :manager
  end
end