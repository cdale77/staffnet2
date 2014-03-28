desc 'Heroku scheduler file'

task :update_sendy => :environment do
  updates = SendyUpdate.where(success: false)
  Sendy::PerformUpdates.perform(updates)
end