class DuplicateRecordPolicy < Struct.new(:user, :record)

  def new_batch?
    user.role? :admin
  end

  def index? 
    user.role? :admin
  end

  def resolve?
    user.role? :admin
  end
end
