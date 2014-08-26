class AddPaycheckIdToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :paycheck_id, :integer
    add_index :shifts, :paycheck_id
  end
end
