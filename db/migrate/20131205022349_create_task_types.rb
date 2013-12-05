class CreateTaskTypes < ActiveRecord::Migration
  def change
    create_table :task_types do |t|
      t.string  :name, :default => ''
      t.string  :desc, :default => ''
    end
  end
end
