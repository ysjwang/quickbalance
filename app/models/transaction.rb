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
  attr_accessible :amount, :credited_id, :custom_credit, :custom_debit, :debited_id, :description, :user_id

  belongs_to :user

  belongs_to :debited, :class_name => "Account"
  belongs_to :credited, :class_name => "Account"

  before_validation :sanitize_debit, :sanitize_credit

  validates :amount, :presence => true

  private

  	def sanitize_debit
  		# set debited_id to 0 if the custom debit is NOT blank
  		self.debited_id = nil if !self.custom_debit.blank?
  	end

  	def sanitize_credit
  		# set credited_id to 0 if custom_credit is NOT blank
      self.creditd_id = nil if !self.custom_credit.blank?
  	end

  	def validate
  		if (self.debited_id || self.credited_id)
  			if self.debited_id == self.credited_id
  				errors.add_to_base "Credit and Debit cannot be the same party"
  			end
  		end
  	end


end
