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


  validates :name, presence: true
  validates :credit_shorthand, presence: true
  validates :debit_shorthand, presence: true
  validates :user_id, presence: true

  # Custom validations
  validate :validate_unique_shorthands



  # BEGIN PRIVATE
  private

  def validate_unique_shorthands
    # First, get the user
    user = User.find_by_id(user_id)

    if user
      # Then, find all their accounts
      accounts = user.accounts

      shorthand_array = []

      accounts.each do |account|
        if !account.id.blank? # forces to only looked at saved accounts, not our current one...
          shorthand_array.push(account.credit_shorthand)  # Compile their account credit shorthands into array
          shorthand_array.push(account.debit_shorthand) # Compile their account debit shorthands into same array
        end
      end

      if shorthand_array.include?(credit_shorthand)
        errors.add(:credit_shorthand, "is a duplicate of another shorthand")
      end

      if shorthand_array.include?(debit_shorthand)
        errors.add(:debit_shorthand, "is a duplicate of another shorthand")
      end
    else
      errors.add(:user_id, "not specified")

    end


  end
end