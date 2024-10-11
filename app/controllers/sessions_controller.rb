# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_user_login, only: %i[new callback failure]

  def new; end

  def callback
    user = User.find_or_create_from_discord_info(request.env['omniauth.auth'])

    if user.persisted?
      reset_session
      login(user)
      redirect_to root_path # TODO: flash message
    else
      redirect_to login_path # TODO: error message
    end
  end

  def failure
    # TODO: failure message
    redirect_to login_path
  end
end
