class CreatePaymentProfiles < ActiveRecord::Migration
  def change
    execute 'CREATE EXTENSION hstore'
    create_table :payment_profiles do |t|
      t.integer :supporter_id 
      t.string :cim_payment_profile_id, :default => ''
      t.string :details, :hstore, :default => {}
      t.timestamps
    end

    add_index :payment_profiles, :supporter_id
    add_index :payment_profiles, :cim_payment_profile_id
  end
end
