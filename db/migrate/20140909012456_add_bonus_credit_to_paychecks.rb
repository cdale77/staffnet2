class AddBonusCreditToPaychecks < ActiveRecord::Migration
  def change
    add_column :paychecks, :bonus_credit, :decimal, scale: 2,
               precision: 8, default: 0.00
  end
end
