class CreateSupporterTypes < ActiveRecord::Migration
  def change
    create_table :supporter_types do |t|
      t.string  :name, :default => ''

      t.timestamps
      t.datetime    :mailchimp_sync_at
    end
  end
end
