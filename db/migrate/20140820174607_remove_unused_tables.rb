class RemoveUnusedTables < ActiveRecord::Migration
  def change
    drop_table :clients
    drop_table :projects
    drop_table :task_types
    drop_table :tasks
  end
end
