ShiftPolicy = Struct.new(:user, :record) do

  Scope = Struct.new(:user, :scope) do
    def resolve
      if user.role? :manager
        scope
      else
        scope.where(:user == user)
      end
    end
  end

  def new?
    user.role? :staff
  end

  def create?
    user.role? :manager or user == record.user
  end

  def show?
    user.role? :manager or user == record.user
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