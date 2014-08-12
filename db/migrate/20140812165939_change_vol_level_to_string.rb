class ChangeVolLevelToString < ActiveRecord::Migration
  def change
    remove_column :supporters, :vol_level
    add_column :supporters, :vol_level, :string, default: ""
  end
end
