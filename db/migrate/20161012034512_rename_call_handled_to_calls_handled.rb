class RenameCallHandledToCallsHandled < ActiveRecord::Migration[5.0]
  def change
    rename_column :intervals, :call_handled, :calls_handled
  end
end
