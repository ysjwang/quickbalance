class SmsController < ApplicationController

	def create

		@from = params['From']
		@body = params['Body']
		puts "GOT TWILIO. FROM #{@from} and body is #{@body}"

		render xml: "<Response/>"
	end
end
