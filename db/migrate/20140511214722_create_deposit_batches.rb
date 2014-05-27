class CreateDepositBatches < ActiveRecord::Migration
  def change
    create_table :deposit_batches do |t|
      t.integer :employee_id, index: true
      t.string  :batch_type, default: ''
      t.date    :date
      t.boolean :deposited, default: false

      t.timestamps
    end
  end
end
