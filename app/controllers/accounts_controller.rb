class AccountsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @account = Account.new
  end

  def create


    @account = current_user.accounts.new(account_params)


    if @account.save
    @accounts = current_user.accounts.reload # Thanks Leger on stackoverflow!
      #redirect_to accounts_path, :success => "Account successfully created."
      flash[:success] = "Account sucessfully created."
      # respond_to :js
      respond_to do |format|
        format.js {
          render :create
        }
      end

      
    else
    @accounts = current_user.accounts.reload # Thanks Leger on stackoverflow!

    

    flash[:error] = "There was a problem with adding your account."
    respond_to do |format|
      format.js {
        render :create
      }
    end
    
  end




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
