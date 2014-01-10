module MailChimpMethods
  extend ActiveSupport::Concern

  module ClassMethods
    def mailchimp_records_to_sync
      where("updated_at > mailchimp_sync_at")
    end
  end
end