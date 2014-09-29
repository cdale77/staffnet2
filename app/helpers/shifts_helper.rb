module ShiftsHelper 

  def cache_key_for_shifts
    count          = Shift.count
    max_updated_at = Shift.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "shifts/all-#{count}-#{max_updated_at}"
  end
end
