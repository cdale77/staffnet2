class CreateShiftTypes < ActiveRecord::Migration
  def change
    create_table(:shift_types) do |t|
      t.string :shift_type, default: ''
      t.timestamps
    end

    add_index :shift_types, :shift_type

  end
end
