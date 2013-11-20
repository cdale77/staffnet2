class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :client_id
      t.string  :name, :default => ''
      t.date    :start_date
      t.date    :end_date
      t.string  :desc, :default => ''
      t.text    :notes, :default => ''
      t.timestamps
    end

    add_index :projects, :client_id
  end
end
