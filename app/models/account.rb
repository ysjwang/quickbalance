# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  debit_shorthand  :string(255)
#  credit_shorthand :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :credit_shorthand, :debit_shorthand, :name, :user_id, :credit_transactions, :debit_transactions


  belongs_to :user

  has_many :credit_transactions, :class_name => "Transaction", :foreign_key => 'credited_id'
  has_many :debit_transactions, :class_name => "Transaction", :foreign_key => 'debited_id'

  has_many :pending_credit_transactions, :class_name => "PendingTransaction", :foreign_key => 'credited_id'

  has_many :pending_debit_transactions, :class_name => 'PendingTransaction', :foreign_key => 'debited_id'

  
end
