require "active_job"

class SendyUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(update_id)
    success = false
    update = SendyUpdate.find(update_id)
    supporter = Supporter.find(update.supporter_id)
    sendy_list = SendyList.find(update.sendy_list_id)

    sendy_list_identifier = sendy_list.sendy_list_identifier
    action = update.action.to_sym
    options = build_options(supporter: supporter)

    if supporter.email_1.present? && \
       !supporter.do_not_email && \
       !supporter.email_1_bad

      # only actually subscribe them if they can get emails
      success = Sendyr::Client.new(sendy_list_identifier).send(action, options)
      supporter.sendy_status = action
      supporter.sendy_updated_at = Time.now
      supporter.save
    end

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

