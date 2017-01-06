class AddSustainerToSupporters < ActiveRecord::Migration
  def change
  	add_column :supporters, :sustainer, :boolean, default: false
  end
end
