class CreateShiftTypes < ActiveRecord::Migration
  def change
    create_table(:shift_types) do |t|
      t.string :name, default: ''
      t.timestamps
    end

  end
end
