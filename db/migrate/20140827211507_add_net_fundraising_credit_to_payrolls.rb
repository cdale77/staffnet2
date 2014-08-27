class AddNetFundraisingCreditToPayrolls < ActiveRecord::Migration
  def change
    add_column :payrolls, :net_fundraising_credit, :decimal, scale: 2,
        precision: 8, default: 0.00
  end
end
