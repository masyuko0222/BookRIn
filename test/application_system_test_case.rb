# frozen_string_literal: true

require 'test_helper'
require 'supports/test_auth_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include TestAuthHelper

  if ENV['HEADFULL']
    driven_by :selenium, using: :chrome
  else
    driven_by :selenium, using: :headless_chrome
  end
end
