class CreateSendyLists < ActiveRecord::Migration
  def change
    create_table :sendy_lists do |t|
      t.integer :supporter_type_id
      t.string  :sendy_list_identifier, :default => ''
      t.string  :name, :default => ''
      t.timestamps
    end

    add_index :sendy_lists, :supporter_type_id
    add_index :sendy_lists, :sendy_list_identifier
  end
end
