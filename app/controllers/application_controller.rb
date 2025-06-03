# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  helper_method :current_user
  before_action :store_location
  before_action :require_user_login

  def store_location
    return unless request.get?
    return if request.xhr?
    return if request.path.in?([login_path, '/auth/discord/callback', '/auth/failure'])

    session[:previous_url] = request.fullpath
  end
end
