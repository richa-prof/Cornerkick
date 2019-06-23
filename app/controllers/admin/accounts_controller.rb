module Admin
  class AccountsController < AdminController
    before_action :set_account, only: %i[show edit update destroy]

    # GET /accounts
    def index
      @accounts = policy_scope(Account).page params[:page]
    end

    # GET /accounts/1
    def show
      authorize @account
    end

    # GET /accounts/new
    def new
      @account = Account.new
      authorize @account
    end

    # GET /accounts/1/edit
    def edit
      authorize @account
    end

    # POST /accounts
    def create
      @account = Account.new(account_params)
      authorize @account

      if @account.save
        redirect_to admin_account_url(@account), notice: 'Account was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /accounts/1
    def update
      authorize @account
      if @account.update(account_params)
        redirect_to admin_account_url(@account), notice: 'Account was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /accounts/1
    def destroy
      authorize @account
      @account.destroy
      redirect_to admin_accounts_url, notice: 'Account was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:name)
    end
  end
end
