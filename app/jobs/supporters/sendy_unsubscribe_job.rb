require "active_job"

class SendyUnsubscribeJob < ActiveJob::Base
  queue_as :default

  def perform(update_id)
    success = false
    update = SendyUpdate.find(update_id)
    sendy_list = SendyList.find(update.sendy_list_id)
    sendy_list_identifier = sendy_list.sendy_list_identifier
    options = build_options

    success = Sendyr::Client.new(sendy_list_identifier).unsubscribe(options)

    ## attempt to update the supporter, if they are still in the db
    begin
      supporter = Supporter.find(update.supporter_id)
      supporter.sendy_status = "unsubscribe"
      supporter.sendy_updated_at = Time.now
      supporter.save
    rescue
      puts "Sendy Unsub: could not update supporter id #{update.supporter_id}"
    end

    mark_complete(update: update, success: success)
  end

  private
    def mark_complete(update:, success:)
      update.completed_at = Time.now
      update.success = success
      update.save
    end

    def build_options
      { :email => update.sendy_email }
    end
end

