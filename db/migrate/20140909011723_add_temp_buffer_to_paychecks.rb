class AddTempBufferToPaychecks < ActiveRecord::Migration
  def change
    add_column :paychecks, :temp_buffer, :decimal, scale: 2,
               precision: 8, default: 0.00
  end
end
