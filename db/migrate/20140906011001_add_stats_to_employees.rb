class AddStatsToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :shifts_lifetime, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :shifts_this_pay_period, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :shifts_this_week, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :fundraising_shifts_lifetime, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :fundraising_shifts_this_pay_period, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :fundraising_shifts_this_week, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :donations_lifetime, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :donations_this_pay_period, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :donations_this_week, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :successful_donations_lifetime, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :successful_donations_this_pay_period, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :successful_donations_this_week, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :raised_lifetime, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :raised_this_pay_period, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :raised_this_week, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :average_lifetime, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :average_this_pay_period, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :employees, :average_this_week, :decimal, scale: 2,
               precision: 8, default: 0.00
  end
end
