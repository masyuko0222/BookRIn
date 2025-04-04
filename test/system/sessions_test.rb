# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
      provider: 'discord',
      uid: '12345678',
      info: {
        name: 'Alice'
      }
    )
  end

  teardown do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:discord] = nil
  end

  test 'login' do
    visit login_path
    click_on 'Login with Discord'
    assert_current_path root_path
    assert_text 'ログインしました'
  end
end
