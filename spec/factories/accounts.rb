require 'faker'

FactoryGirl.define do 
	factory :account do
		name {'Account Name'}
		debit_shorthand {'w'}
		credit_shorthand {'X'}
		user_id { '1' }
	end

	
end