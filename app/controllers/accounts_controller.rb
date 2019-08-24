class AccountsController < CornerkickController
  before_action :set_account, except: %i[edit_current_account update_current_account]

  def dashboard
    authorize @account

    @visit_count = 'N/A' # Visit.joins(:contact).where(event_type: 'visit', cornerkick_contacts: { account_id: @account }).count
    @click_count = 'N/A' # Visit.joins(:contact).where(event_type: 'click', cornerkick_contacts: { account_id: @account }).count

    @recent = Contact.where(account: @account).order(updated_at: :desc).limit(10)
  end

  # GET /accounts/1
  def show
    authorize @account
  end

  # GET /accounts/current_account
  def edit_current_account
    skip_authorization
    @accounts = policy_scope(Account)
  end

  # PUT /accounts/current_account
  def update_current_account
    account_select = params[:account]
    @account = Account.find account_select
    authorize @account, :dashboard?

    session[:account_id] = @account.id

    redirect_to dashboard_account_url(@account), notice: 'Changed Account'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.fetch(:account, {})
  end
end
