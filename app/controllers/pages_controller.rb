class PagesController < ApplicationController

	before_filter :authenticate_user!, :only => [:home]


	def home
		@transaction = current_user.transactions.new
		@transactions = current_user.transactions.all(:order => 'created_at DESC')

		@pending_transaction = current_user.pending_transactions.new
		@pending_transactions = current_user.pending_transactions.all(:order => 'created_at DESC')
	end
end
