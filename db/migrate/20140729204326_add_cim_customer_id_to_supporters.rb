class AddCimCustomerIdToSupporters < ActiveRecord::Migration
  def change
    add_column :supporters, :cim_customer_id, :string, default: ""

  end
end
