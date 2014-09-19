class AddIndicesToThings < ActiveRecord::Migration
  def change
    add_index :deposit_batches, :employee_id
    add_index :donations, :sub_month
    add_index :donations, :sub_week
    add_index :donations, :donation_type
    remove_index :employees, :phone
    remove_index :employees, :email
    remove_index :employees, :last_name
    add_index :paychecks, :check_date
    add_index :payments, :payment_type
    add_index :payrolls, :start_date
    add_index :payrolls, :end_date
    add_index :sendy_lists, :name
    add_index :shift_types, :name
    add_index :shifts, :date
    add_index :supporter_types, :name
    remove_index :supporters, :external_id
    add_index :supporters, :prospect_group
  end
end
