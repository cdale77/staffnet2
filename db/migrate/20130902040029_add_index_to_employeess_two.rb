class AddIndexToEmployeessTwo < ActiveRecord::Migration
  def change
    add_index :employees, :active
    add_index :employees, :title
    add_index :employees, :last_name
  end
end
