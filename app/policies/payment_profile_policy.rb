class PaymentProfilePolicy < Struct.new(:user, :record)

  def new?
    user.role? :staff
  end

  def create?
    user.role? :staff
  end
end