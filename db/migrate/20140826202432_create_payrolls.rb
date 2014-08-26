class CreatePayrolls < ActiveRecord::Migration
  def change
    create_table :payrolls do |t|
      t.date :start_date
      t.date :end_date

      t.integer :check_quantity, default: 0
      t.integer :shift_quantity, default: 0
      t.integer :cv_shift_quantity, default: 0
      t.integer :quota_shift_quantity, default: 0
      t.integer :office_shift_quantity, default: 0
      t.integer :sick_shift_quantity, default: 0
      t.integer :vacation_shift_quantity, default: 0

      t.decimal :total_deposit, scale: 2, precision: 8, default: 0.00
      t.decimal :total_fundraising_credit, scale: 2, precision: 8, default: 0.00

      t.timestamps
    end
  end
end
