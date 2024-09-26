# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def callback
    user = User.find_or_create_from_discord_info(request.env['omniauth.auth'])

    if user.persisted?
      reset_session
      session[:user_id] = user.id
      redirect_to root_path # TODO: flash message
    else
      redirect_to login_path # TODO: error message
    end
  end

  def failure
    redirect_to login_path # TODO: failure message
  end
end
