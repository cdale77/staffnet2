class AddQuotaShiftFlagToShiftTypes < ActiveRecord::Migration
  def change
    add_column :shift_types, :quota_shift, :boolean, default: true
    add_index :shift_types, :quota_shift
  end
end
