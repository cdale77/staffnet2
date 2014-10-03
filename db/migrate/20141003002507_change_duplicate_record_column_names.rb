class ChangeDuplicateRecordColumnNames < ActiveRecord::Migration
  def change
    remove_index :duplicate_records, :primary_record_id
    rename_column :duplicate_records, :primary_record_id, :first_record_id
    rename_column :duplicate_records, :duplicate_record_ids, :additional_record_ids
    add_index :duplicate_records, :first_record_id
  end
end
