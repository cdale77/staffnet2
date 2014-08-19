class RemoveCvAndQuotaFlagsFromShifts < ActiveRecord::Migration
  def change
    remove_column :shifts, :quota_shift
    remove_column :shifts, :cv_shift
  end
end
