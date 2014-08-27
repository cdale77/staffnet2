class AddPayrollFields < ActiveRecord::Migration
  def change
    add_column :payrolls, :notes, :text, default: ""
    add_column :paychecks, :notes, :text, default: ""
    add_column :employees, :daily_quota, :decimal, scale: 2, precision: 8,
               default: 0.00
    remove_column :payrolls, :total_fundraising_credit
    remove_column :paychecks, :total_fundraising_credit

    add_column :payrolls, :gross_fundraising_credit, :decimal, scale: 2,
                  precision: 8, default: 0.00
    add_column :paychecks, :gross_fundraising_credit, :decimal, scale: 2,
                  precision: 8, default: 0.00

    add_column :paychecks, :credits, :decimal, scale: 2, precision: 8,
               default: 0.00
    add_column :paychecks, :docks, :decimal, scale: 2, precision: 8,
               default: 0.00
    add_column :paychecks, :total_quota, :decimal, scale: 2, precision: 8,
               default: 0.00
    add_column :paychecks, :net_fundraising_credit, :decimal, scale: 2,
               precision: 8, default: 0.00
    add_column :paychecks, :over_quota, :decimal, scale: 2, precision: 8,
               default: 0.00

  end
end
