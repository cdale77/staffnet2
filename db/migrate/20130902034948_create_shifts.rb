class CreateShifts < ActiveRecord::Migration
  def change
    execute 'CREATE EXTENSION hstore'
    create_table :shifts do |t|
      t.integer     :employee_id
      t.integer     :field_manager_employee_id
      t.integer     :shift_type_id
      t.string      :legacy_id, default: ''
      t.date        :date
      t.time        :time_in
      t.time        :time_out
      t.integer     :break_time, default: 0
      t.text        :notes, default: ''
      t.decimal     :travel_reimb, scale: 2, precision: 8, default: 0.00
      t.boolean     :cv_shift, default: false
      t.boolean     :quota_shift, default: false
      t.hstore      :products, default: {}
      t.decimal     :reported_raised, scale: 2, precision: 8, default: 0.00
      t.integer     :cash_qty, default: 0
      t.decimal     :cash_amt, scale: 2, precision: 8, default: 0.00
      t.integer     :check_qty, default: 0
      t.decimal     :check_amt, scale: 2, precision: 8, default: 0.00
      t.integer     :one_time_cc_qty, default: 0
      t.decimal     :one_time_cc_amt, scale: 2, precision: 8, default: 0.00
      t.integer     :monthly_cc_qty, default: 0
      t.decimal     :monthly_cc_amt, scale: 2, precision: 8, default: 0.00
      t.integer     :quarterly_cc_amt, default: 0
      t.decimal     :quarterly_cc_qty, scale: 2, precision: 8, default: 0.00

      t.timestamps
    end

    add_index :shifts, :employee_id
    add_index :shifts, :shift_type_id
    add_index :shifts, :field_manager_employee_id
  end
end
