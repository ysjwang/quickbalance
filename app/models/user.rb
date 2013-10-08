# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :first_name, :last_name, :phone

  attr_accessible :transaction_attributes
  attr_accessible :pending_transactions_attributes

  has_many :transactions
  has_many :pending_transactions
  has_many :accounts

  accepts_nested_attributes_for :transactions
  accepts_nested_attributes_for :pending_transactions
  # attr_accessible :title, :body

  before_validation :phone_to_number

  after_create :create_default_accounts

  def debit_shorthands
  	shorthands = Array.new
  	self.accounts.each do |account|
  		shorthands.push(account.debit_shorthand)
  	end
  	return shorthands
  end

  def credit_shorthands
  	shorthands = Array.new
  	self.accounts.each do |account|
  		shorthands.push(account.credit_shorthand)
  	end
  	return shorthands
  end

  def full_name
  	return self.first_name + ' ' + self.last_name
  end


  private

  	def phone_to_number
  		self.phone = self.phone.gsub(/\D/, '')
  	end

  	def create_default_accounts
  		self.accounts.create(name: "Wallet", debit_shorthand: "w", credit_shorthand: "W")
  	end

end
