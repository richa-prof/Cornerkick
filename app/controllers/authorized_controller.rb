# frozen_string_literal: true

class AuthorizedController < ApplicationController
  include Pundit

  protect_from_forgery with: :exception
end
