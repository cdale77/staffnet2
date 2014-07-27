class AddReceiptFieldToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :receipt_sent_at, :datetime
  end
end
