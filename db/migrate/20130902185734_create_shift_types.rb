class CreateShiftTypes < ActiveRecord::Migration
  def change
    create_table(:shift_types) do |t|
      t.string :name, default: ''
      t.decimal     :monthly_cc_multiplier, scale: 2, precision: 8, default: 0.00
      t.decimal     :quarterly_cc_multiplier, scale: 2, precision: 8, default: 0.00

      t.timestamps
    end

  end
end
