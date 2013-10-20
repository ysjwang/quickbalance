require 'faker'

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

FactoryGirl.define do
	factory :user do
		email { Faker::Internet.email }
		password { 'password' }
		password_confirmation { 'password' }
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		phone { '+1' + (0...10).map { rand(9) }.join.to_s } # we'll need to test with this format for now.

		factory :user_without_default_accounts do
			after(:build) do |user| 
				User.skip_callback(:create, :after, :create_default_accounts)
			end
		end

	end
end