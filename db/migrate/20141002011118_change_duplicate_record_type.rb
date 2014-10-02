class ChangeDuplicateRecordType < ActiveRecord::Migration
  def change
    remove_column :duplicate_records, :record_type
    add_column :duplicate_records, :record_type_name, :string, default: true
  end
end
