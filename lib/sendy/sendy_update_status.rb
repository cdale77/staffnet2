module Sendy
  class UpdateStatus

    ## This class represents a list stored on the Sendy server. For now it does one thing -- pull data from Sendy,
    ## compare it to the database, and queue an update to be made later.

    ## Sendyr forces a connection to Sendy based on list.

    ## needs to be updated to reference the sendy list db table. SendyUpdate::create needs a sendy list id paramater


    def initialize(sendy_list_identifier)
      @client = Sendyr::Client.new(sendy_list_identifier)
    end

=begin
    def active_subscriber_count
      @client.active_subscriber_count
    end

    def queue_updates_from_sendy
      supporter_type = SupporterType.find_by_sendy_list_id(@client.list_id)
      supporters = supporter_type.supporters.where("email_1 <> '' AND do_not_email IS FALSE")
      supporters.find_each do |supporter|

        begin
          sendy_status = @client.subscription_status(email: suppporter.email_1).to_s
        rescue
          puts "Error getting Sendy status for supporter id #{supporter.id.to_s}."
          next
        end

        #if the status recieved from Sendy matches the existing status, no updates
        unless sendy_status == supporter.sendy_status
          SendyUpdate.create( supporter_id: supporter.id,
                              supporter_type_id: supporter_type.id,
                              action: 'update_database',
                              new_sendy_status: sendy_status)
        end
      end
    end
=end
  end
end