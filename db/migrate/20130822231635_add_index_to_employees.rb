class AddIndexToEmployees < ActiveRecord::Migration
  def change
    add_index :employees, :email
    add_index :employees, :hire_date
    add_index :employees, :term_date
    add_index :employees, :phone
  end
end
