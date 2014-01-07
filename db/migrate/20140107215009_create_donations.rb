class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :supporter_id
      t.integer :shift_id
      t.date    :date
      t.string  :donation_type, :default => ''
      t.string  :source, :default => ''
      t.string  :campaign, :default => ''
      t.string  :sub_month, limit: 1, :default => ''
      t.integer :sub_week, limit: 1, :default => 0
      t.decimal :amount, :scale => 2, :precision=> 8, :default => 0
      t.boolean :cancelled, :default => false
      t.text    :notes, :default => ''

      t.timestamps
    end

    add_index :donations, :supporter_id
    add_index :donations, :shift_id

  end
end
