class CreateTableDuplicates < ActiveRecord::Migration
  def change
    create_table :duplicate_records do |t|
      t.string      :record_type, default: ""
      t.integer     :primary_record_id
      t.string      :duplicate_record_ids, array: true, default: []
      t.timestamps
    end
    add_index :duplicate_records, :primary_record_id
  end
end
