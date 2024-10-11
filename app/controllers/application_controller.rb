# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper

  include Authentication
  before_action :require_user_login
end
