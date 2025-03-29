class TermController < ApplicationController
  skip_before_action :require_user_login, only: %i[show]

  def show; end
end
