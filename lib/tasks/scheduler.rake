desc 'Heroku scheduler file'

task :update_mailchimp => :environment do
  SupporterType.mailchimp_sync_records

end