class SmsController < ApplicationController

	def create

		sms_from = params['From']
		sms_body = params['Body']
		puts "GOT TWILIO. FROM #{sms_from} and body is #{sms_body}"

		render xml: "<Response/>"


		# First, we'll need to remove the '+' sign from the @from
		sms_from.slice!(0)

		@user = User.find_by_phone(sms_from)
		if @user
			# user exists
			#create the pending_transaction
			puts "The number #{sms_from} belongs to #{@user.email}"
			@pending_transaction = @user.pending_transactions.new(shortcode: sms_body)
			if @pending_transaction.save
				# okay, transaction saved
				# text back something....
				puts "We were able to save the transaction #{sms_body}"

			else
				# text back error...
				puts "We weren't able to save the transaction #{sms_body}"

			end


		else
			# No need to do anything, phone not recognized in system.
			puts "We didn't find a user with phone #{sms_from}"
		end



	end
end
