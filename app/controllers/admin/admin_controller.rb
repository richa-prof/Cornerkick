module Admin
  # Separate root controller for /admin since it is wholly decoupled from a current account concept.
  class AdminController < ApplicationController
    include Pundit

    protect_from_forgery with: :exception

    before_action :authenticate_user!

    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
  end
end
