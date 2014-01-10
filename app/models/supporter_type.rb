# == Schema Information
#
# Table name: supporter_types
#
#  id                :integer          not null, primary key
#  name              :string(255)      default("")
#  created_at        :datetime
#  updated_at        :datetime
#  mailchimp_sync_at :datetime
#

class SupporterType < ActiveRecord::Base

  ## SETUP ENVIRONMENT
  include MailChimpMethods

  ## VALIDATIONS
  validates :name, presence: { message: 'required.' },
            length: { maximum: 56, minimum: 2, message: 'must be between 2 and 56 characters.' }

  ## RELATIONSHIPS
  has_many :supporters

  ## CALLBACKS
  #after_save :create_mailchimp_group
  #before_destroy :destroy_mailchimp_group



=begin
  def create_mailchimp_group
    # probably should not check the group names every time we make a supporter group. At least in testing.
    unless mailchimp_group_names.include? self.name
      gb = Gibbon::API.new
      gb.lists.interest_group_add(  id: ENV['MAILCHIMP_LIST_ID'],
                                    group_name: self.name,
                                    group_id: ENV['MAILCHIMP_LIST_SUPPORTER_GROUP_ID'] )
    end
  end

  def mailchimp_group_names
    names = []
    gb = Gibbon::API.new
    mailchimp_groups = gb.lists.interest_groupings(id: ENV['MAILCHIMP_LIST_ID'])[0]['groups']
    mailchimp_groups.each do |group|
      names << group['name']
    end
    names
  end

  def destroy_mailchimp_group
    gb = Gibbon::API.new
    gb.lists.interest_group_del( id: ENV['MAILCHIMP_LIST_ID'],
                                 group_name: self.name,
                                 group_id: ENV['MAILCHIMP_LIST_SUPPORTER_GROUP_ID']  )
  end
=end

  def number_of_supporters
    self.supporters.count
  end

end
