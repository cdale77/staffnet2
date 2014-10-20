module PayrollsHelper 

  def cache_key_for_payrolls
    count          = Payroll.count
    max_updated_at = Payroll.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "payrolls/all-#{count}-#{max_updated_at}"
  end
end
