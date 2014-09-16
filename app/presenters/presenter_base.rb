class PresenterBase < SimpleDelegator

  include ActionView::Helpers::NumberHelper

  def self.wrap(collection)
    collection.map do |obj|
      new obj
    end
  end

  def model
    __getobj__
  end

  # All models have magic columns
  def formatted_created_at
    I18n.l(created_at, format: :long)
  end

  def formatted_updated_at
    I18n.l(updated_at, format: :long)
  end

  # Many, but not all, underlying objects have these two methods.
  def formatted_amount
    number_to_currency(amount)
  end

  def formatted_date
    I18n.l(date)
  end
end
