class AddFundraisingShiftFlagToShiftTypes < ActiveRecord::Migration
  def change
    add_column :shift_types, :fundraising_shift, :boolean, default: false
    add_index :shift_types, :fundraising_shift
  end
end
