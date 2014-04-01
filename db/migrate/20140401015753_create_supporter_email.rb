class CreateSupporterEmail < ActiveRecord::Migration
  def change
    create_table :supporter_emails do |t|
      t.integer     :supporter_id, index: true
      t.integer     :employee_id, index: true
      t.integer     :donation_id
      t.string      :email_type, default: ''
      t.text        :body, default: ''
      t.boolean     :success, default: false

      t.timestamps
    end
  end
end
