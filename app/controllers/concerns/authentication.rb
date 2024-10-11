# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern
  include SessionHelper

  def require_user_login
    return if logged_in?

    redirect_to login_path, alert: 'ログインしてください'
  end
end
