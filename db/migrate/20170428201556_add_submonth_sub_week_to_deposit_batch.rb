class AddSubmonthSubWeekToDepositBatch < ActiveRecord::Migration
  def change
    add_column :deposit_batches, :sub_month, :string, default: ""
    add_column :deposit_batches, :sub_week, :string, default: ""
  end
end
