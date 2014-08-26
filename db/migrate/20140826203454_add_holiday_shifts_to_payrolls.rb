class AddHolidayShiftsToPayrolls < ActiveRecord::Migration
  def change
    add_column :payrolls, :holiday_shift_quantity, :integer, default: 0
  end
end
