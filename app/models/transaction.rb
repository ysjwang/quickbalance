class Transaction < ActiveRecord::Base
  attr_accessible :amount, :credited_id, :custom_credit, :custom_debit, :debited_id, :description, :user_id
end
