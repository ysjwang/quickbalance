class PendingTransaction < ActiveRecord::Base
  attr_accessible :amount, :credited_id, :custom_credit, :custom_debit, :debited_id, :desecription, :shortcode, :user_id
end
