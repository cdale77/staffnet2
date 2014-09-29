module SupportersHelper 

  def cache_key_for_supporters
    count          = Supporter.count
    max_updated_at = Supporter.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "supporters/all-#{count}-#{max_updated_at}"
  end


  def cache_key_for_supporter_types
    count          = SupporterType.count
    max_updated_at = SupporterType.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "supporter_types/all-#{count}-#{max_updated_at}"
  end
end
