class DuplicateRecordPolicy < Struct.new(:user, :record)

  def new_batch?
    user.role? :admin
  end

  def new_file?
    user.role? :admin
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

