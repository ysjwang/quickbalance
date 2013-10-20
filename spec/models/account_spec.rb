require 'spec_helper.rb'

describe Account do

	before :each do 
		# @account = 
	end


	it 'should be valid with a name, credit shorthand, debit shorthand, and user id' do
		user = create(:user_without_default_accounts)
		
		account = build(:account, user: user)

		# account = build(:account)
		expect(account).to be_valid
	end

	it 'should not be valid without a name' do
		account = build(:account, name: nil)
		expect(account).to have_at_least(1).errors_on(:name)
	end

	it 'should not be valid without a credit shorthand' do
		account = build(:account, credit_shorthand: nil)
		expect(account).to have_at_least(1).errors_on(:credit_shorthand)
	end

	it 'should not be valid without a debit shorthand' do
		account = build(:account, debit_shorthand: nil)
		expect(account).to have_at_least(1).errors_on(:debit_shorthand)
	end

	it 'should not be valid without a user' do
		account = build(:account, user_id: nil)
		expect(account).to have_at_least(1).errors_on(:user_id)
	end

	it 'should not be valid with a duplicate shorthand by same user' do 
		
		user = create(:user_without_default_accounts)
		account1 = create(:account, credit_shorthand: 'w', debit_shorthand: 'W', user: user)

		account2 = build(:account, credit_shorthand: 'w', debit_shorthand: 'X', user: user)
		expect(account2).to have_at_least(1).errors_on(:credit_shorthand)

		account3 = build(:account, credit_shorthand: 'W', debit_shorthand: 'x', user: user)
		expect(account3).to have_at_least(1).errors_on(:credit_shorthand)

		account4 = build(:account, credit_shorthand: 'x', debit_shorthand: 'w', user: user)
		expect(account4).to have_at_least(1).errors_on(:debit_shorthand)

	end

	it 'should be valid valid duplicate shorthand by different users' do
		user1 = create(:user_without_default_accounts)
		account1 = create(:account, credit_shorthand: 'W', debit_shorthand: 'w', user: user1)

		user2 = create(:user_without_default_accounts)
		account2 = build(:account, credit_shorthand: 'W', debit_shorthand: 'w', user: user2)
		expect(account2).to be_valid

	end


end