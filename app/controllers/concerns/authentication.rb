# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def require_user_login
    return if logged_in?

    redirect_to login_path, alert: 'ログインしてください'
  end

  def login(user)
    session[:user_id] = user.id
  end

  private

  def logged_in?
    current_user.present?
  end
end
