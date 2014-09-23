require "active_job"

class SubWeek5To4Job < ActiveJob::Base
  queue_as :default


  def perform
    donations = Donation.where(sub_week: 5)
    puts "Updating #{donations.count} donations"
    donations.each do |donation|
      if donation.update_columns(sub_week: 4)
        puts "Updated donation id #{donation.id}"
      else
        puts "Could not update donation id #{donation.id}"
      end
    end
  end
end
