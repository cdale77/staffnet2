class AddTotalSalaryToShifts < ActiveRecord::Migration
  def change
    add_column :paychecks, :total_salary, :decimal, scale: 2,
                  precision: 8, default: 0.00
  end
end
