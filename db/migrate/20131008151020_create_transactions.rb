class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.decimal :amount, :precision => 8, :scale => 2
      t.text :description
      t.integer :credited_id
      t.integer :debited_id
      t.string :custom_credit
      t.string :custom_debit
      t.integer

      t.timestamps
    end
  end
end
