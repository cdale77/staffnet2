require "active_job"

class UpdateProspectGroupJob < ActiveJob::Base
  queue_as :default

  def perform
    Supporter.find_each do |supporter|
      donations = supporter.donations
      if donations.any?
        last_donation = donations.first
        if last_donation.date > (Date.today - 1.day)
          supporter.prospect_group = PROSPECT_GROUPS[last_donation.date.month]
          supporter.save
        end
      end
    end
  end
end
