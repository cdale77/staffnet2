class CreateFullContactMatches < ActiveRecord::Migration
  def change
    create_table :full_contact_matches do |t|
      t.integer :supporter_id
      t.json    :payload
      t.timestamps
    end
    add_index :full_contact_matches, :supporter_id
  end
end
