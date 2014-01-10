module MailChimpMethods
  extend ActiveSupport::Concern

  def set_mailchimp_sync_stamp
    self.mailchimp_sync_at = (Time.now - 24.hours) unless !self.mailchimp_sync_at.blank?
  end

  module ClassMethods
    def mailchimp_records_to_sync
      where("updated_at > mailchimp_sync_at")
    end
  end
end