class AddEmployeeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :employee_id, :integer
  end
end
