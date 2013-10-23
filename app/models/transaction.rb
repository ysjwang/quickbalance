# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  amount        :decimal(8, 2)
#  description   :text
#  credited_id   :integer
#  debited_id    :integer
#  custom_credit :string(255)
#  custom_debit  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Transaction < ActiveRecord::Base
  # attr_accessible :amount, :credited_id, :custom_credit, :custom_debit, :debited_id, :description, :user_id

  belongs_to :user

  belongs_to :debited, :class_name => "Account"
  belongs_to :credited, :class_name => "Account"

  before_validation :sanitize_debit, :sanitize_credit

  validates :amount, :presence => true
  validates :user_id, :presence => true

  # Custom validations
  validate :validate_unique_debit_credit
  validate :validate_debit_presence
  validate :validate_credit_presence

  private

  def sanitize_debit
    # set debited_id to 0 if the custom debit is NOT blank
    self.debited_id = nil if !self.custom_debit.blank?
  end

  def sanitize_credit
    # set credited_id to 0 if custom_credit is NOT blank
    self.credited_id = nil if !self.custom_credit.blank?
  end

  def validate_unique_debit_credit
    if (self.debited_id || self.credited_id)
      if self.debited_id == self.credited_id
        errors.add(:debited_id, "cannot be the same as credit party.")
        errors.add(:credited_id, "cannot be the same as debit party.")
      end
    end
  end

  def validate_debit_presence
    if (self.debited_id.blank? && self.custom_debit.blank?)
      # if both debited_id and custom_debit are blank
      errors.add(:debited_id, "or custom debit must be set.")
      errors.add(:custom_debit, "or a pre-set debit party must be set.")
    end
  end

  def validate_credit_presence
    if (self.credited_id.blank? && self.custom_credit.blank?)
      # if both debited_id and custom_debit are blank
      errors.add(:credited_id, "or custom credit must be set.")
      errors.add(:custom_credit, "or a pre-set credit party must be set.")
    end
  end


end
