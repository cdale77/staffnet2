desc "Data maintenance tasks"

namespace :maintenance do

  task update_prospect_group: :environment do
    puts "Updating prospect group codes"

    Supporter.find_each do |supporter|
      supporter.update_prospect_group
      supporter.save
    end
  end
end