class AddWorkersCompToShiftTypes < ActiveRecord::Migration
  def change
    add_column :shift_types, :workers_comp_type, :string, default: ""
  end
end
