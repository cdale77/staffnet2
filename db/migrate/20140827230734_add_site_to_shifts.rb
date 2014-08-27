class AddSiteToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :site, :string, default: ""
  end
end
