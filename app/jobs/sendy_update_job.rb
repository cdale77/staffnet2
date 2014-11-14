require "active_job"

class SendyUpdateJob < ActiveJob::Base
  queue_as :default

  def perform
    updates = SendyUpdate.where(success: false)
    success = false

    updates.each do |update|
      puts "Performing update id #{update.id}"

      client = Sendyr::Client.new(sendy_list_identifier)

      begin
        supporter = Supporter.find(update.supporter_id.to_i)
      rescue
        handle_error(update_id: update.id, msg: "Could not find supporter")
        next
      end

      begin
        sendy_list = SendyList.find(update.send_list_id.to_i)
      rescue
        handle_error(update_id: update.id, msg: "Could not find Sendy list")
        next
      end

      if supporter.email_1.present? && \
         !supporter.do_not_email && \
         !supporter.email_1_bad

        success = perform_update(update: update,
                                supporter: supporter,
                                sendy_list: sendy_list)

      end
      mark_completed(update: update, success: success)
    end
  end

  private

  def handle_error(update_id:, msg: "Something went wrong")
    # raise a custom exception class here
  end

  def mark_completed(update:, success:)
    update.completed_at = Time.now
    update.result = success
  end

  def perform_update(update: update, supporter: supporter, sendy_list: sendy_list)
    case update.action
      when "subscribe"
        subscribe_to_sendy(supporter, sendy_list.sendy_list_identifier)
      when "unsubscribe"
        unsubscribe_from_sendy(supporter, sendy_list.sendy_list_identifier)
    end
  end

  def subscribe_to_sendy(supporter, sendy_list_identifier)
      client.subscribe(:email => supporter.email_1,
                       :name => supporter.full_name,
                       "FirstName" => supporter.first_name,
                       "LastName" => supporter.last_name)
  end

  def unsubscribe_from_sendy(supporter, sendy_list_identifier)
    client.unsubscribe(:email => supporter.email_1, :name => supporter.full_name )
  end
end

