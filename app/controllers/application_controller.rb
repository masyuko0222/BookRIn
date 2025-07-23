# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  helper_method :current_user
  before_action :require_user_login
  before_action :store_location
end
