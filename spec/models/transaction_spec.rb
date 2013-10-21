require 'spec_helper.rb'

describe Transaction do

	it 'should be valid with a user_id, amount, description, credited_id OR custom credit, and debited_id OR custom_debit'
	
	it 'should be invalid without either a credited_id or custom_credit' do
		transaction = build(:transaction, credited_id: nil, custom_credit: nil)
		expect(transaction).to have_at_least(1).errors_on (:credited_id)
		expect(transaction).to have_at_least(1).errors_on (:custom_credit) 
	end

	it 'should be invalid without either a debited_id or custom_debit' do
		transaction = build(:transaction, debited_id: nil, custom_debit: nil)
		expect(transaction).to have_at_least(1).errors_on (:debited_id)
		expect(transaction).to have_at_least(1).errors_on (:custom_debit)
	end

	it 'should be invalid without an amount' do
		transaction = build(:transaction, amount: nil)
		expect(transaction).to have_at_least(1).errors_on (:amount)
	end

	it 'should be invalid without a user' do
		transaction = build(:transaction, user_id: nil)
		expect(transaction).to have_at_least(1).errors_on (:user_id)
	end

	it 'should be invalid with the same credited_id and debited_id' do
		transaction = build(:transaction, credited_id: 1, debited_id: 1)
		expect(transaction).to have_at_least(1).errors_on (:credited_id)
		expect(transaction).to have_at_least(1).errors_on (:debited_id)
	end
	
end


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