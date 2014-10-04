class CreateDataReports < ActiveRecord::Migration
  def change
    create_table :data_reports do |t|
      t.integer :user_id
      t.string :data_report_type_name, default: ""
      t.attachment :downloadable_file
      t.timestamps
    end
    add_index :data_reports, :user_id
  end
end
