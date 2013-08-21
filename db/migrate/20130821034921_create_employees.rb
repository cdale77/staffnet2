class CreateEmployees < ActiveRecord::Migration
  def change
    create_table(:employees) do |t|
      t.string :first_name, :default => ''
      t.string :last_name, :default => ''
      t.string :email, :default => ''
      t.string :phone, :default => ''
      t.string :address1, :default => ''
      t.string :address2, :default => ''
      t.string :city, :default => ''
      t.string :state, :default => ''
      t.string :zip, :default => ''
      t.string :title, :default => ''
      t.string :pay_hourly, :decimal, :scale => 2, :precision=> 8, :default => 0.00
      t.string :pay_daily, :decimal, :scale => 2, :precision=> 8, :default => 0.00
      t.date :hire_date
      t.date :term_date
      t.string :fed_filing_status, :default => ''
      t.string :ca_filing_stats, :default => ''
      t.integer :fed_allowances, :default => 0
      t.integer :ca_allowances, :default => 0
      t.date :dob
      t.string :gender, :default => ''
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
