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

end
