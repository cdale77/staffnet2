class AddPaperclipToPayrolls < ActiveRecord::Migration
  def change
    add_attachment :payrolls, :paycheck_report
    add_attachment :payrolls, :shift_report
  end
end
