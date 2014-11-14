module Sendy

  class UpdateStatus

    ## This class represents a list stored on the Sendy server. For now it does one thing -- pull data from Sendy,
    ## compare it to the database, and queue an update to be made later.

    ## Sendyr forces a connection to Sendy based on list.

    def self.queue_updates_from_sendy(sendy_list)

      client = Sendyr::Client.new(sendy_list.sendy_list_identifier)



      sendy_list.supporters.where("email_1 <> '' AND do_not_email IS FALSE").find_each do |supporter|

        begin
          sendy_status = client.subscription_status(email: supporter.email_1).to_s
        rescue
          puts "Error getting Sendy status for supporter id #{supporter.id.to_s}."
          next
        end

        #if the status recieved from Sendy matches the existing status, no updates
        if sendy_status != supporter.sendy_status

          if SendyUpdate.create( supporter_id: supporter.id,
                                            sendy_list_id: sendy_list.id,
                                            sendy_email: supporter.email_1,
                                            new_sendy_email: supporter.email_1,
                                            action: 'update_database',
                                            new_sendy_status: sendy_status)
            puts "Created update record for supporter id #{supporter.id.to_s}"
          else
            puts "Something went wrong creating update record for supporter id #{supporter.id.to_s}"
          end
        end
      end
    end
  end

end
