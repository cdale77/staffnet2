class AddResolvedFlagToDuplicateRecords < ActiveRecord::Migration
  def change
    add_column :duplicate_records, :resolved, :boolean, default: false
    add_index :duplicate_records, :resolved, where: "resolved = false"
  end
end
