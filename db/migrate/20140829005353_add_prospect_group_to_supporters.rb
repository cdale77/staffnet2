class AddProspectGroupToSupporters < ActiveRecord::Migration
  def change
    add_column :supporters, :prospect_group, :string, default: ""
  end
end
