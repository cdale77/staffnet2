module MailChimpMethods
  extend ActiveSupport::Concern

  def set_mailchimp_sync_stamp
    self.mailchimp_sync_at = (Time.now - 24.hours) unless !self.mailchimp_sync_at.blank?
  end

  def update_mailchimp_sync
    self.mailchimp_sync_at = Time.now + 1.second
    if self.save
      puts 'Updated mailchimp timestamp'
    else
      puts 'ERROR updating mailchimp timestamp'
    end
  end

  module ClassMethods
    def mailchimp_records_to_sync
      where("updated_at > mailchimp_sync_at")
    end
  end
end