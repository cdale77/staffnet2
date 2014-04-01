# == Schema Information
#
# Table name: supporter_emails
#
#  id           :integer          not null, primary key
#  supporter_id :integer
#  employee_id  :integer
#  donation_id  :integer
#  email_type   :string(255)      default("")
#  body         :text             default("")
#  success      :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

class SupporterEmail < ActiveRecord::Base

  belongs_to :supporter
  belongs_to :employee

  before_save :send

  private

    def send
      case self.email_type
        when 'receipt'
          if SupporterMailer.receipt(self).deliver
            self.success = true
          end
        when 'prospect'
          if SupporterMailer.prospect(self).deliver
            self.success = true
          end
        when 'pledge'
          if SupporterMailer.pledge(self).deliver
            self.success = true
          end
      end
    end
end
