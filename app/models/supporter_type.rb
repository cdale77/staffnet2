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
  before_create :set_mailchimp_sync_stamp

  def number_of_supporters
    self.supporters.count
  end

  ## MailChimp
  def self.mailchimp_sync_records

    connection = Gibbon::API.new

    # cache the current MailChimp group names so we don't make too many API calls
    mailchimp_groups = MailChimp::Group.group_names(connection)

    mailchimp_records_to_sync.map do |record|

      if mailchimp_groups.include? record.name
        puts 'Record exists.'
        record.update_mailchimp_sync
      elsif MailChimp::Group.add_group(connection, record.name)
        record.update_mailchimp_sync
        puts 'Updating record for group ' + record.name
      else
        puts 'ERROR - did not update MailChimp group record for ' + record.name
      end

      sleep 2 # pause to make it easier on MailChimp API
    end
  end


end
