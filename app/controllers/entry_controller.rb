class EntryController < CornerkickController
  skip_before_action :session_account, only: %i[no_account]
  skip_after_action :verify_authorized, only: %i[no_account]

  def root
    authorize @current_account, :dashboard?
    redirect_to dashboard_account_path(@current_account)
  end

  def no_account

  end
end
