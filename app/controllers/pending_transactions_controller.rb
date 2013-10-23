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

    if ( pending_transaction.user_id == params[:pending_transaction][:user_id].to_i ) && pending_transaction.is_confirm_ready?
      # Successful confirm
      pending_transaction.confirm_transaction
      flash[:success] = "Successfully confirmed this pending transaction."
      
    else
      # failed confirm
      flash[:error] = "Something was wrong with confirming your pending transaction."

    end
    @pending_transactions = current_user.pending_transactions.all
    @transactions = current_user.transactions.all

  end

  def create
    @pending_transaction = current_user.pending_transactions.new(pending_transactions_params)
    if @pending_transaction.save
      @pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')
      @transaction = current_user.transactions.new(params[:transaction])
      
      @transactions = current_user.transactions.all(order: 'created_at DESC')

      flash[:success] = "Successfully created this pending transaction."

      respond_to do |format|
        format.js {
          render :create
        }
      end


      #redirect_to pages_home_path, :success => "Pending Transaction successfully created."
      
    else
      @pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')

     

      @transaction = current_user.transactions.new(params[:transaction])
      @transactions = current_user.transactions.all(order: 'created_at DESC')

      flash[:error] = "There was a problem with your pending transaction."

      respond_to do |format|
        format.js {
          render :create
        }
      end

      
      #render 'pages/home'
    end


  end


  def destroy
    @pending_transaction = PendingTransaction.find(params[:id])
    @pending_transaction.destroy
    flash[:success] = "Successfully removed pending transaction."
    @pending_transactions = current_user.pending_transactions.all
  end


  def index
    @pending_transaction = current_user.pending_transactions.new
    @pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')

  end

  private

  # def record_not_valid
  #   puts "IHOW DID I GET HERE??????"
  #   @pending_transaction = current_user.pending_transactions.new(pending_transactions_params)
  #   @pending_transactions = current_user.pending_transactions.all(order: 'created_at DESC')
  #   @transaction = current_user.transactions.new(params[:transaction])
  #   @transactions = current_user.transactions.all(order: 'created_at DESC')
  #   puts "Before the flash"
  #   flash[:error] = "Something was wrong with confirming your pending transaction."
  #   puts "after the flash"
  #   # render 'pages/home'
  #   puts "after home"

  # end

  def pending_transactions_params
    # attr_accessible :amount, :credited_id, :custom_credit, :custom_debit, :debited_id, :desecription, :shortcode, :user_id
    params.require(:pending_transaction).permit(:amount, :credited_id, :custom_credit, :custom_debit, :debited_id, :description, :shortcode, :user_id)
  end


end
