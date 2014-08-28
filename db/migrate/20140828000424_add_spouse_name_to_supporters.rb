class AddSpouseNameToSupporters < ActiveRecord::Migration
  def change
    add_column :supporters, :spouse_name, :string, default: ""
  end
end
