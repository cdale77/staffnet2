class CreatePaymentProfiles < ActiveRecord::Migration
  def change
    create_table :payment_profiles do |t|
      t.integer :supporter_id 
      t.string :cim_payment_profile_id, :default => ''
      t.string :payment_profile_type, :default => ''
      t.hstore :details, :default => {}
      t.timestamps
    end

    add_index :payment_profiles, :supporter_id
    add_index :payment_profiles, :cim_payment_profile_id
  end
end
