class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :debit_shorthand
      t.string :credit_shorthand
      t.integer :user_id

      t.timestamps
    end
  end
end
