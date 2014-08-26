class AddVacationShiftsToPayrolls < ActiveRecord::Migration
  def change
    add_column :payrolls, :vacation_shift_quantity, :decimal,
               scale: 2, precision: 8, default: 0.00
  end
end
