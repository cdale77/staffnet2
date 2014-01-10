module MailChimp


  class Group
    def self.group_names(connection)
      names = []
      connection.lists.interest_groupings(id: ENV['MAILCHIMP_LIST_ID'])[0]['groups'].each do |group|
        names << group['name']
      end
      names
    end

    def self.add_group(connection, name)
      connection.lists.interest_group_add(  id: ENV['MAILCHIMP_LIST_ID'],
                                            group_name: name,
                                            group_id: ENV['MAILCHIMP_LIST_SUPPORTER_GROUP_ID'] )
    end
  end

end