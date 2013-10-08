class Account < ActiveRecord::Base
  attr_accessible :credit_shorthand, :debit_shorthand, :name, :user_id
end
