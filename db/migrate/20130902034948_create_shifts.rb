class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :employee_id
      t.integer :shift_type_id
      t.date    :date
      t.time    :time_in
      t.time    :time_out
      t.integer :break_time, :default => 0
      t.string  :notes, :default => ''
      t.decimal :travel_reimb,  :scale => 2, :precision=> 8, :default => 0.00

      t.timestamps
    end

    add_index :shifts, :employee_id
    add_index :shifts, :shift_type
    add_index :shifts, :date
  end
end
