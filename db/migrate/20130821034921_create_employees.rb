class CreateEmployees < ActiveRecord::Migration
  def change
    create_table(:employees) do |t|
      t.integer :user_id
      t.string :first_name, :default => ''
      t.string :last_name, :default => ''
      t.string :email, :default => ''
      t.string :phone, :default => ''
      t.string :address1, :default => ''
      t.string :address2, :default => ''
      t.string :address_city, :default => ''
      t.string :address_state, :default => ''
      t.string :address_zip, :default => ''
      t.string :title, :default => ''
      t.decimal :pay_hourly, :scale => 2, :precision=> 8, :default => 0.00
      t.decimal :pay_daily, :scale => 2, :precision=> 8, :default => 0.00
      t.date :hire_date
      t.date :term_date
      t.string :fed_filing_status, :default => ''
      t.string :ca_filing_status, :default => ''
      t.integer :fed_allowances, :default => 0
      t.integer :ca_allowances, :default => 0
      t.date :dob
      t.string :gender, :default => ''
      t.boolean :active, :default => true

      t.timestamps
    end

    add_index :employees, :user_id
    add_index :employees, :email
    add_index :employees, :hire_date
    add_index :employees, :term_date
    add_index :employees, :phone
    add_index :employees, :active
    add_index :employees, :title
    add_index :employees, :last_name
  end
end
