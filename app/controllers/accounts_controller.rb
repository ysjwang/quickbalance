class AccountsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @account = Account.new
  end

  def create

    puts "%%%%%%%%%%%%%%%%%%%%Prelim Accounts is #{current_user.accounts.count} compared to #{current_user.accounts.all.count}"

    @account = current_user.accounts.new(account_params)
    puts "%%%%%%%%%%%%%%%%%%%%First Accounts is #{current_user.accounts.count} compared to #{current_user.accounts.all.count}"


    if @account.save
      @accounts = current_user.accounts.all(order: 'created_at DESC')
      #redirect_to accounts_path, :success => "Account successfully created."
      flash[:success] = "Account sucessfully created."
      # respond_to :js
      respond_to do |format|
        format.js {
          render :create
        }
      end
      puts "%%%%%%%%%%%%%%%%%%%%Success Accounts is #{@accounts.count} compared to #{current_user.accounts.all.count} compared to #{current_user.accounts.count}"

      
    else
      @accounts = current_user.accounts.all(order: 'created_at DESC')

      @accounts.each do |hello|
        puts "+1"

      end

      flash[:error] = "There was a problem with adding your account."
      respond_to do |format|
        format.js {
          render :create
        }
      end
      # render 'index'

      #render 'new'
      puts 'endof nay'
      puts "%%%%%%%%%%%%%%%%%%%%Fail Accounts is #{@accounts.count} compared to #{current_user.accounts.all.count} compared to #{current_user.accounts.count}"

    end

    puts "%%%%%%%%%%%%%%%%%%%%Final Accounts is #{@accounts.count} compared to #{current_user.accounts.all.count} compared to #{current_user.accounts.count}"



  end

  def show
    @account = Account.find_by_id(params[:id])
    @debit_transactions = @account.debit_transactions.all
    @credit_transactions = @account.credit_transactions.all

    @transactions = (@debit_transactions + @credit_transactions).uniq
    @transactions.sort! { |a,b| b.created_at <=> a.created_at }
  end

  def index
    @accounts = current_user.accounts.all
    puts "index renders accounts as #{@accounts.count}"
  end

  private

  def account_params
    # attr_accessible :credit_shorthand, :debit_shorthand, :name, :user_id, :credit_transactions, :debit_transactions
    params.require(:account).permit(:credit_shorthand, :debit_shorthand, :name, :user_id, :credit_transactions, :debit_transactions)
  end



end
