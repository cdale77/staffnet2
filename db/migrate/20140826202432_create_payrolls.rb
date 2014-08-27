class CreatePayrolls < ActiveRecord::Migration
  def change
    create_table :payrolls do |t|
      t.date :start_date
      t.date :end_date

      t.integer :check_quantity, default: 0
      t.decimal :shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :cv_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :quota_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :office_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :sick_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :holiday_shift_quantity, scale: 2, precision: 8, default: 0.00
      t.decimal :holiday_shift_quantity, scale: 2, precision: 8, default: 0.00

      t.decimal :total_deposit, scale: 2, precision: 8, default: 0.00
      t.decimal :gross_fundraising_credit, scale: 2, precision: 8, default: 0.00

      t.timestamps
    end
  end
end
