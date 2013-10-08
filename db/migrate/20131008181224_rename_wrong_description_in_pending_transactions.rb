class RenameWrongDescriptionInPendingTransactions < ActiveRecord::Migration
  def up
  	rename_column :pending_transactions, :desecription, :description
  end

  def down
  	rename_column :pending_transactions, :description, :desecription
  end
end
