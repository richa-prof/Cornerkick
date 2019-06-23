class CornerkickController < ApplicationController
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :session_account

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  protect_from_forgery with: :exception

  def session_account
    return unless current_user

    current_account_id = session[:account_id]

    if current_account_id.nil?
      user = current_user
      account = nil
      if user.site_admin?
        account = Account.first
      else
        user = current_user
        account = user.role_assignments.first.account if user.role_assignments.first

      end
      current_account_id = account.id if account

      session[:account_id] = current_account_id
    end

    if current_account_id
      @current_account_id = current_account_id
      @current_account = Account.find current_account_id
    else
      redirect_to no_account_url
    end
  end
end
