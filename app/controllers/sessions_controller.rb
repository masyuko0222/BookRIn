# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_user_login, only: %i[new callback failure]

  def new; end

  def callback
    user = User.find_or_create_from_discord_info(request.env['omniauth.auth'])

    if user.persisted?
      reset_session
      login(user)
      flash[:notice] = 'ログインしました'
      redirect_to root_path
    else
      flash[:alert] = 'ログインに失敗しました 再度お試しください。'
      redirect_to login_path
    end
  end

  def failure
    flash[:alert] = '認証に失敗しました 時間を空けてもう一度お試しください。'
    redirect_to login_path
  end
end
