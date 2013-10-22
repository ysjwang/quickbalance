# == Schema Information
#
# Table name: pending_transactions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  amount        :decimal(, )
#  description   :text
#  custom_credit :string(255)
#  custom_debit  :string(255)
#  shortcode     :string(255)
#  credited_id   :integer
#  debited_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PendingTransaction < ActiveRecord::Base
  attr_accessible :amount, :credited_id, :custom_credit, :custom_debit, :debited_id, :desecription, :shortcode, :user_id

  belongs_to :user
  belongs_to :debited, :class_name => "Account"
  belongs_to :credited, :class_name => "Account"

  validates :shortcode, :presence => true

  before_save :interpret_shortcode

  def confirm_transaction
    # create a new Transaction object with the values in this pending transaction.


    # if self.debited_id exists, then don't fill in the custom_debit
    save_custom_debit = self.debited_id ? "" : self.custom_debit
    save_custom_credit = self.credited_id ? "" : self.custom_credit

    if self.user.transactions.create!(
      amount: self.amount,
      description: self.description,
      debited_id: self.debited_id,
      credited_id: self.credited_id,
      custom_debit: save_custom_debit,
      custom_credit: save_custom_credit)

      # successfully created...
      self.destroy # we don't need this pending transaction anymore.
    end
  end

  def interpret_shortcode
    # Possible formats we're expecting:
    # w 100     = This means we spent 100 from w
    # w 100 Bob   = This means we debit w 100 to a custom person Bob

    ## TODO: THESE NEXT TWO EXAMPLES DON'T WORK YET.
    ## We don't have support for using a shortcode outside of the designed position
    ## DESIGNATED POSITIONS: left is DEBIT FROM, right is CREDIT TO.
    # W 100     = This means we put 100 into W
    # W 100 Bob   = This means credit W 100 from Bob

    # Thus, we assume the first two arguments are required.
    # <first> = debit
    # <second> = amount
    # <third> = ???
    # Ideally, break by the *middle* NUMBER.

    # What we CAN do easily: split by the first number we see in the shortcode (ie, the '100' in 'w 100 Bob', which means we gave 100 from w to Bob)

    # A transaction has the following: debit_id, custom_debit, amount, credit_id, custom_credit, description

    # First - explode the input into an array
    # We first find the pivot - the NUMERICAL Amount
    amount = self.shortcode.scan(/[-+]?[0-9]*\.?[0-9]+/).first

    if amount.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true

      # alright, this is a number. we can proceed.

      # Next, we split the shortcode.
      # We know that there will be only a left side and a right side after the pivot.

      # split it into 2 parts
      transaction_args = self.shortcode.split(amount, 2)
      debit_code = transaction_args.first.strip
      credit_code = transaction_args.last.strip

      ## TODO: Need to check shortcodes don't correspond to the SAME account!

      # Now that we have the debit_code and credit_code, we see if they match any of the user's predefined shorthands

      debit = self.user.accounts.find_by_debit_shorthand(debit_code)
      if debit
        # Shortcode we found matches a user's account
        puts "We found a debit"
        debited_id = debit.id
        custom_debit = debit.name
      else
        # Shortcode provided does NOT match a user's account
        puts "We didn't find a debit"
        debited_id = nil
        custom_debit = debit_code # We will just have to assume this is a nonsensical account.
      end


      # Perform the same for credit_code
      credit = self.user.accounts.find_by_credit_shorthand(credit_code)
      if credit
        # Shortcode is a hit for credit account
        credited_id = credit.id
        custom_credit = credit.name
      else
        credited_id = nil
        custom_credit = credit_code
      end


      # Now that we have all the information we need, we will set the information.
      self.amount = amount
      self.debited_id = debited_id
      self.custom_debit = custom_debit
      self.credited_id = credited_id
      self.custom_credit = custom_credit
    else
      # We couldn't find a number to pivot upon
      puts "Not a number"
    end
  end

  private

  ## TODO: need to make sure that 'w' and 'W' (or shortcodes for debit and credit) don't go the same party as well.
  def validate
    if (self.debited_id || self.credited_id)
      if self.debited_id == self.credited_id
        errors.add_to_base "Credit and Debit cannot be the same party"
      end
    end
  end


end
