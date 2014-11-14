require "active_job"

class SendyUpdateJob < ActiveJob::Base
  queue_as :default

  def perform
    updates = SendyUpdate.where(success: false)
    success = false

    updates.each do |update|
      puts "Performing update id #{update.id}"

      begin
        supporter = Supporter.find(update.supporter_id.to_i)
        sendy_list = SendyList.find(update.send_list_id.to_i)
        client = Sendyr::Client.new(sendy_list.sendy_list_identifier)
      rescue
        mark_complete(update: update, success: false)
        next
      end

      # only actually subscribe them if they can get emails
      if supporter.email_1.present? && \
         !supporter.do_not_email && \
         !supporter.email_1_bad

        success = perform_update(update: update,
                                 supporter: supporter,
                                 sendy_list: sendy_list)
      else
        success = true
      end

      mark_complete(update: update, success: success)
      update.save
      supporter.save
    end
  end

  private

  def mark_complete(update:, success:)
    update.completed_at = Time.now
    update.success = success
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

