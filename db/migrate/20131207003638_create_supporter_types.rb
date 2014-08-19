class CreateSupporterTypes < ActiveRecord::Migration
  def change
    create_table :supporter_types do |t|
      t.string  :name, :default => ''

      t.timestamps
    end
  end
end