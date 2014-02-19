class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :shift_id
      t.integer :project_id
      t.integer :task_type_id
      t.string  :legacy_id, :default => ''
      t.string  :name, :default => ''
      t.decimal :hours, :scale => 2, :precision=> 8, :default => 0.00
      t.string  :desc, :default => ''
      t.text    :notes, :default => ''
      t.timestamps
    end

    add_index :tasks, :shift_id
    add_index :tasks, :project_id
    add_index :tasks, :task_type_id
  end
end
