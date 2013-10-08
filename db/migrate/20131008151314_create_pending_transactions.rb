class CreatePendingTransactions < ActiveRecord::Migration
  def change
    create_table :pending_transactions do |t|
      t.integer :user_id
      t.decimal :amount
      t.text :desecription
      t.string :custom_credit
      t.string :custom_debit
      t.string :shortcode
      t.integer :credited_id
      t.integer :debited_id

      t.timestamps
    end
  end
end
