class CreateMigrationErrors < ActiveRecord::Migration
  def change
    create_table :migration_errors do |t|

      t.integer :record_id
      t.string  :record_name, :default => ''
      t.string  :message, :default => ''

      t.timestamps
    end
  end
end
