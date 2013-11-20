class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string  :name, :default => ''
      t.string  :address1, :default => ''
      t.string  :address2, :default => ''
      t.string  :city, :default => ''
      t.string  :state, :default => ''
      t.string  :zip, :default => ''
      t.string  :contact_name, :default => ''
      t.string  :contact_phone, :default => ''
      t.string  :contact_email, :default => ''
      t.string  :uri, :default => ''
      t.text    :notes, :default => ''
      t.timestamps
    end
  end
end
