class PendingTransactionsController < ApplicationController
	rescue_from ActiveRecord::RecordInvalid, :with => :record_not_valid

	before_filter :authenticate_user!

	def show
	end

	def new
		@pending_transaction = current_user.pending_transactions.new
	end

	def confirm

		pending_transaction = PendingTransaction.find_by_id(params[:pending_transaction][:id])

		# check if the transaction's user id is the same as the one submitted...why??
		if pending_transaction.user_id == params[:pending_transaction][:user_id].to_i
			pending_transaction.confirm_transaction
			flash[:success] = "Successfully confirmed this pending transaction."
			@pending_transactions = PendingTransaction.all
			@transactions = Transaction.all
		end
		# redirect_to pages_home_path, :success => "Confirmed pending transaction"

	end

	def create
		@pending_transaction = current_user.pending_transactions.new(params[:pending_transaction])

		if @pending_transaction.save
			@pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')
			@transaction = current_user.transactions.new(params[:transaction])
			@transactions = current_user.transactions.all(order: 'created_at DESC')

			#redirect_to pages_home_path, :success => "Pending Transaction successfully created."
			flash[:success] = "Successfully created this pending transaction."
		else
			@pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')
			@transaction = current_user.transactions.new(params[:transaction])
			@transactions = current_user.transactions.all(order: 'created_at DESC')
			flash[:error] = "There was a problem with your pending transaction."
			#render 'pages/home'
		end
	end

	def destroy
		@pending_transaction = PendingTransaction.find(params[:id])
		@pending_transaction.destroy
		flash[:success] = "Successfully removed pending transaction."
		@pending_transactions = PendingTransaction.all
	end


	def index
		@pending_transaction = current_user.pending_transactions.new
		@pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')

	end

	private

		def record_not_valid
			@pending_transaction = current_user.pending_transactions.new(param[:pending_transaction])
			@pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')
			@transaction = current_user.transactions.new(params[:transaction])
			@transactions = current_user.transactions.all(order: 'created_at DESC')
			flash[:error] = "Something was wrong with confirming your pending transaction."
			render 'pages/home'

		end


end
