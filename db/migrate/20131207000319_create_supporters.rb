class CreateSupporters < ActiveRecord::Migration
  def change
    create_table :supporters do |t|

      t.integer :supporter_type_id
      t.integer :sendy_list_id
      t.string  :legacy_id, :default => ''

      t.string :external_id, :default => ''
      t.string :cim_id, :default => ''

      t.string  :prefix, :default => ''
      t.string  :salutation, :default => ''
      t.string  :first_name, :default => ''
      t.string  :last_name, :default => ''
      t.string  :suffix, :default => ''

      t.string  :address1, :default => ''
      t.string  :address2, :default => ''
      t.string  :address_city, :default => ''
      t.string  :address_state, :default => ''
      t.string  :address_zip, :default => ''
      t.string  :address_county, :default => ''
      t.boolean :address_bad, :default => FALSE

      t.string  :email_1, :default => ''
      t.boolean :email_1_bad, :default => FALSE
      t.string  :email_2, :default => ''
      t.boolean :email_2_bad, :default => FALSE

      t.string  :phone_mobile, :default => ''
      t.boolean :phone_mobile_bad, :default => FALSE
      t.string  :phone_home, :default => ''
      t.boolean :phone_home_bad, :default => FALSE
      t.string  :phone_alt, :default => ''
      t.boolean :phone_alt_bad, :default => FALSE

      t.boolean :do_not_mail, :default => FALSE
      t.boolean :do_not_call, :default => FALSE
      t.boolean :do_not_email, :default => FALSE

      t.boolean :keep_informed, :default => FALSE
      t.integer :vol_level, :default => 0

      t.string :employer, :default => ''
      t.string :occupation, :default => ''

      t.string :source, :default => ''
      t.text :notes, :default => ''

      t.string :sendy_status, :default => ''

      t.datetime :sendy_updated_at
      t.timestamps
    end

    add_index :supporters, :supporter_type_id
    add_index :supporters, :sendy_list_id
    add_index :supporters, :external_id
    add_index :supporters, :cim_id
  end
end
