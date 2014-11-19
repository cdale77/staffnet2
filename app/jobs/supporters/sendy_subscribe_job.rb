require "active_job"

class SendySubscribeJob < ActiveJob::Base
  queue_as :default

  def perform(update_id)
    success = false
    update = SendyUpdate.find(update_id)
    supporter = Supporter.find(update.supporter_id)
    sendy_list = SendyList.find(update.sendy_list_id)

    sendy_list_identifier = sendy_list.sendy_list_identifier
    options = build_options(supporter: supporter)

    success = Sendyr::Client.new(sendy_list_identifier).subscribe(options)
    supporter.sendy_status = "subscribe"
    supporter.sendy_updated_at = Time.now
    supporter.save

    mark_complete(update: update, success: success)
  end

  private
    def mark_complete(update:, success:)
      update.completed_at = Time.now
      update.success = success
      update.save
    end

    def build_options(supporter:)
      { :email => supporter.email_1,
        :name => supporter.full_name,
        "FirstName" => supporter.first_name,
        "LastName" => supporter.last_name }
    end
end

