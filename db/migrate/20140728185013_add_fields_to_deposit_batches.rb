class AddFieldsToDepositBatches < ActiveRecord::Migration
  def change
    add_column :deposit_batches, :approved, :boolean, default: false
    add_column :deposit_batches, :receipt_number, :string, default: ""
  end
end
