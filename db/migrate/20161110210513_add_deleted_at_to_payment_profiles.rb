class AddDeletedAtToPaymentProfiles < ActiveRecord::Migration
  def change
    add_column :payment_profiles, :deleted_at, :datetime
    add_index :payment_profiles, :deleted_at
  end
end
