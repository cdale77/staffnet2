class CreatePaychecks < ActiveRecord::Migration
  def change
    create_table :paychecks do |t|
      t.integer :payroll_id
      t.integer :employee_id
      t.date    :check_date

      t.decimal :shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :cv_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :quota_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :office_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :sick_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :vacation_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :holiday_shift_quantity, scale: 2, precision: 8, default: 0.00

      t.decimal :total_deposit, scale: 2, precision: 8, default: 0.00
      t.decimal :gross_fundraising_credit, scale: 2, precision: 8, default: 0.00
      t.decimal :old_buffer, scale: 2, precision: 8, default: 0.00
      t.decimal :new_buffer, scale: 2, precision: 8, default: 0.00

      t.decimal :total_pay, scale: 2, precision: 8, default: 0.00
      t.decimal :bonus, scale: 2, precision: 8, default: 0.00
      t.decimal :travel_reimb, scale: 2, precision: 8, default: 0.00

      t.timestamps
    end

    add_index :paychecks, :payroll_id
    add_index :paychecks, :employee_id
  end
end
