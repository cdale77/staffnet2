class AddPayrollFields < ActiveRecord::Migration
  def change
    add_column :payrolls, :notes, :text, default: ""
    add_column :paychecks, :notes, :text, default: ""
    add_column :employees, :daily_quota, :decimal, scale: 2, precision: 8,
               default: 0.00

  end
end
