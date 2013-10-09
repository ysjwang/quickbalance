class TransactionsController < ApplicationController
	before_filter :authenticate_user!
	def new
		@transaction = current_user.transactions.new
	end

	def create
		@transaction = current_user.transactions.new(params[:transaction])

		if @transaction.save
			@transactions = current_user.transactions.all(order: 'created_at DESC')
			@pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')
			@pending_transaction = current_user.pending_transactions.new(params[:pending_transaction])

			redirect_to pages_home_path, :success => "Transaction successfully created."

		else
			@transactions = current_user.transactions.all(order: 'created_at DESC')
			@pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')
			@pending_transaction = current_user.pending_transactions.new(params[:pending_transaction])

			render 'pages/home'
		end

	end

	def index
		@transactions = current_user.transactions.all(order: 'created_at DESC')
	end

	def show
	end

	def destroy
		@transaction = Transaction.find(params[:id])
		@transaction.destroy
		flash[:success] = "Successfully removed transaction."
		@transactions = Transaction.all
	end
end
