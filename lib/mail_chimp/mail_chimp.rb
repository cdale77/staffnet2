module MailChimp


  class Group
    def self.group_names
      names = []
      gb = Gibbon::API.new
      gb.timeout = 15
      mailchimp_groups = gb.lists.interest_groupings(id: ENV['MAILCHIMP_LIST_ID'])[0]['groups']
      mailchimp_groups.each do |group|
        names << group['name']
      end
      names
    end

    def self.add_group(name)
      gb = Gibbon::API.new
      gb.timeout = 10
      gb.lists.interest_group_add(  id: ENV['MAILCHIMP_LIST_ID'],
                                    group_name: name,
                                    group_id: ENV['MAILCHIMP_LIST_SUPPORTER_GROUP_ID'] )
    end
  end

end