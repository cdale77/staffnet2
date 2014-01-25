class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :donation_id
      t.integer :payment_profile_id
      t.string  :cim_transaction_id, :default => ''
      t.integer :user_id
      t.date    :deposited_at
      t.string  :payment_type, :default => ''
      t.boolean :captured, :default => false
      t.decimal :amount, :scale => 2, :precision=> 8, :default => 0
      t.string  :cc_last_4, :limit => 4, :default => ''
      t.string  :cc_month, :limit => 2, :default => ''
      t.string  :cc_year, :limit => 4, :default => ''
      t.string  :cc_type, :default => ''
      t.string  :check_number, :default => ''
      t.text    :notes, :default => ''

      t.timestamps
    end

    add_index :payments, :payment_profile_id
    add_index :payments, :donation_id
    add_index :payments, :user_id
    add_index :payments, :cim_transaction_id

  end
end
