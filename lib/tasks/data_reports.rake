namespace :data_reports do
  desc "Various data reports"

  task master_list: :environment do
    Exports::DonationHistory.all
  end

  task outreach_report: :environment do
    puts "What is the prospect group code?"
    code = STDIN.gets.chomp
    Exports::DonationHistory.prospect_group(code)
  end
end