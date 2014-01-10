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
  before_create { self.mailchimp_sync_at = (Time.now - 24.hours) }

  def number_of_supporters
    self.supporters.count
  end

  ## MailChimp
  def self.mailchimp_sync_records
    mailchimp_groups = MailChimp::Group.group_names
    mailchimp_records_to_sync.map do |record|

      if mailchimp_groups.include? record.name
        puts 'Record exists.'
        record.update_mailchimp_sync
      elsif MailChimp::Group.add_group(record.name)
        puts 'Updating record for group ' + record.name
        record.update_mailchimp_sync
      else
        puts 'ERROR - did not update MailChimp group record for ' + record.name
      end

      sleep 2 # pause because MailChimp likes batched calls. This isn't a batch call, and the volume will be low.
    end
  end

  def update_mailchimp_sync
    self.mailchimp_sync_at = Time.now + 1.second
    if self.save
      puts 'Updated mailchimp timestamp'
    else
      puts 'ERROR updating mailchimp timestamp'
    end
  end
end
