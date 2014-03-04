class CreateSendyUpdates < ActiveRecord::Migration
  def change
    create_table :sendy_updates do |t|
      t.integer   :supporter_id
      t.integer   :sendy_list_id
      t.integer   :sendy_batch_id

      t.string    :sendy_email,       :default => ''
      t.string    :new_sendy_email,   :default => ''
      t.string    :new_sendy_status,  :default => ''
      t.string    :action,            :default => ''

      t.boolean   :success,           :default => false
      t.datetime  :completed_at

      t.timestamps
    end

    add_index :sendy_updates, :supporter_id
    add_index :sendy_updates, :sendy_list_id
    add_index :sendy_updates, :sendy_batch_id
    add_index :sendy_updates, :success
  end
end
