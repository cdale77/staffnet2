class AddEvolveEducationFundBoolean < ActiveRecord::Migration
  def change
  	add_column :donations, :evolve_ed_fund, :boolean, default: false

  	add_index :donations, :evolve_ed_fund 
  end
end
