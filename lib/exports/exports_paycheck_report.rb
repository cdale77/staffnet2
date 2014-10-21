module Exports
  class PaycheckReport < Exports::Base
    columns = %W[last_name
                 pay_hourly
                 pay_daily
                 daily_quota
                 check_date
                 shift_quantity
                 cv_shift_quantity
                 quota_shift_quantity]
  end
